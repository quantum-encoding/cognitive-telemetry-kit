const std = @import("std");
const c = @cImport({
    @cInclude("sqlite3.h");
});

const DB_PATH = "/var/lib/cognitive-watcher/cognitive-states.db";

const ExportOptions = struct {
    output_file: []const u8 = "cognitive-states.csv",
    start_date: ?[]const u8 = null,
    end_date: ?[]const u8 = null,
    pid: ?u32 = null,
    state_filter: ?[]const u8 = null,
    limit: ?usize = null,
    include_raw: bool = false,
};

pub fn main() !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var options = ExportOptions{};

    // Parse arguments
    var i: usize = 1;
    while (i < args.len) : (i += 1) {
        const arg = args[i];

        if (std.mem.eql(u8, arg, "--help") or std.mem.eql(u8, arg, "-h")) {
            printHelp();
            return 0;
        } else if (std.mem.eql(u8, arg, "--output") or std.mem.eql(u8, arg, "-o")) {
            i += 1;
            if (i >= args.len) {
                std.debug.print("Error: --output requires a filename\n", .{});
                return 1;
            }
            options.output_file = args[i];
        } else if (std.mem.eql(u8, arg, "--start")) {
            i += 1;
            if (i >= args.len) {
                std.debug.print("Error: --start requires a date\n", .{});
                return 1;
            }
            options.start_date = args[i];
        } else if (std.mem.eql(u8, arg, "--end")) {
            i += 1;
            if (i >= args.len) {
                std.debug.print("Error: --end requires a date\n", .{});
                return 1;
            }
            options.end_date = args[i];
        } else if (std.mem.eql(u8, arg, "--pid")) {
            i += 1;
            if (i >= args.len) {
                std.debug.print("Error: --pid requires a number\n", .{});
                return 1;
            }
            options.pid = try std.fmt.parseInt(u32, args[i], 10);
        } else if (std.mem.eql(u8, arg, "--state")) {
            i += 1;
            if (i >= args.len) {
                std.debug.print("Error: --state requires a pattern\n", .{});
                return 1;
            }
            options.state_filter = args[i];
        } else if (std.mem.eql(u8, arg, "--limit")) {
            i += 1;
            if (i >= args.len) {
                std.debug.print("Error: --limit requires a number\n", .{});
                return 1;
            }
            options.limit = try std.fmt.parseInt(usize, args[i], 10);
        } else if (std.mem.eql(u8, arg, "--include-raw")) {
            options.include_raw = true;
        }
    }

    try exportToCSV(allocator, options);

    return 0;
}

fn printHelp() void {
    std.debug.print(
        \\cognitive-export - Export cognitive states to CSV
        \\
        \\Usage: cognitive-export [OPTIONS]
        \\
        \\Options:
        \\  -o, --output <file>      Output CSV file (default: cognitive-states.csv)
        \\  --start <date>          Start date filter (YYYY-MM-DD HH:MM:SS)
        \\  --end <date>            End date filter (YYYY-MM-DD HH:MM:SS)
        \\  --pid <number>          Filter by specific PID
        \\  --state <pattern>       Filter by state pattern (SQL LIKE)
        \\  --limit <number>        Limit number of records
        \\  --include-raw           Include raw_content column
        \\  -h, --help              Show this help
        \\
        \\Examples:
        \\  # Export all states
        \\  cognitive-export
        \\
        \\  # Export states for specific PID
        \\  cognitive-export --pid 12345 -o states-12345.csv
        \\
        \\  # Export states from today
        \\  cognitive-export --start "2025-11-03 00:00:00"
        \\
        \\  # Export only "Thinking" states
        \\  cognitive-export --state "%Thinking%"
        \\
        \\  # Export last 1000 states with raw content
        \\  cognitive-export --limit 1000 --include-raw
        \\
    , .{});
}

fn exportToCSV(allocator: std.mem.Allocator, options: ExportOptions) !void {
    // Open database
    var db: ?*c.sqlite3 = null;
    const rc = c.sqlite3_open_v2(
        DB_PATH,
        &db,
        c.SQLITE_OPEN_READONLY | c.SQLITE_OPEN_SHAREDCACHE,
        null,
    );
    if (rc != c.SQLITE_OK) {
        std.debug.print("Failed to open database: {d}\n", .{rc});
        return error.DatabaseOpenFailed;
    }
    defer _ = c.sqlite3_close(db);

    _ = c.sqlite3_busy_timeout(db, 5000);

    // Build query
    var query = std.ArrayList(u8).empty;
    defer query.deinit(allocator);

    try query.appendSlice(allocator, "SELECT id, timestamp_human, ");

    // Extract cognitive state from raw_content
    try query.appendSlice(allocator,
        \\TRIM(substr(raw_content,
        \\  instr(raw_content, '*') + 1,
        \\  CASE
        \\    WHEN instr(substr(raw_content, instr(raw_content, '*')), '(') > 0
        \\    THEN instr(substr(raw_content, instr(raw_content, '*')), '(') - 1
        \\    ELSE length(raw_content)
        \\  END
        \\)) as cognitive_state,
    );

    try query.appendSlice(allocator, "tool_name, status, pid");

    if (options.include_raw) {
        try query.appendSlice(allocator, ", raw_content");
    }

    try query.appendSlice(allocator, " FROM cognitive_states WHERE raw_content LIKE '%*%'");

    // Add filters
    if (options.start_date) |start| {
        try query.appendSlice(allocator, " AND timestamp_human >= '");
        try query.appendSlice(allocator, start);
        try query.appendSlice(allocator, "'");
    }

    if (options.end_date) |end| {
        try query.appendSlice(allocator, " AND timestamp_human <= '");
        try query.appendSlice(allocator, end);
        try query.appendSlice(allocator, "'");
    }

    if (options.pid) |pid| {
        const pid_str = try std.fmt.allocPrint(allocator, " AND pid = {d}", .{pid});
        defer allocator.free(pid_str);
        try query.appendSlice(allocator, pid_str);
    }

    if (options.state_filter) |filter| {
        try query.appendSlice(allocator, " AND raw_content LIKE '");
        try query.appendSlice(allocator, filter);
        try query.appendSlice(allocator, "'");
    }

    try query.appendSlice(allocator, " ORDER BY id DESC");

    if (options.limit) |limit| {
        const limit_str = try std.fmt.allocPrint(allocator, " LIMIT {d}", .{limit});
        defer allocator.free(limit_str);
        try query.appendSlice(allocator, limit_str);
    }

    // Execute query
    var stmt: ?*c.sqlite3_stmt = null;
    const prep_rc = c.sqlite3_prepare_v2(db, query.items.ptr, @intCast(query.items.len), &stmt, null);
    if (prep_rc != c.SQLITE_OK) {
        std.debug.print("Failed to prepare statement: {d}\n", .{prep_rc});
        return error.StatementPrepareFailed;
    }
    defer _ = c.sqlite3_finalize(stmt);

    // Open output file
    const file = try std.fs.cwd().createFile(options.output_file, .{});
    defer file.close();

    // Write CSV header
    try file.writeAll("id,timestamp,cognitive_state,tool_name,status,pid");
    if (options.include_raw) {
        try file.writeAll(",raw_content");
    }
    try file.writeAll("\n");

    // Write rows
    var count: usize = 0;
    while (c.sqlite3_step(stmt) == c.SQLITE_ROW) {
        // id
        const id = c.sqlite3_column_int64(stmt, 0);
        const id_str = try std.fmt.allocPrint(allocator, "{d},", .{id});
        defer allocator.free(id_str);
        try file.writeAll(id_str);

        // timestamp
        if (c.sqlite3_column_text(stmt, 1)) |timestamp| {
            const timestamp_str = std.mem.span(timestamp);
            const ts = try std.fmt.allocPrint(allocator, "\"{s}\",", .{timestamp_str});
            defer allocator.free(ts);
            try file.writeAll(ts);
        } else {
            try file.writeAll(",");
        }

        // cognitive_state
        if (c.sqlite3_column_text(stmt, 2)) |state| {
            const state_str = std.mem.span(state);
            const escaped = try escapeCSV(allocator, state_str);
            defer allocator.free(escaped);
            const st = try std.fmt.allocPrint(allocator, "{s},", .{escaped});
            defer allocator.free(st);
            try file.writeAll(st);
        } else {
            try file.writeAll(",");
        }

        // tool_name
        if (c.sqlite3_column_text(stmt, 3)) |tool| {
            const tool_str = std.mem.span(tool);
            const escaped = try escapeCSV(allocator, tool_str);
            defer allocator.free(escaped);
            const t = try std.fmt.allocPrint(allocator, "{s},", .{escaped});
            defer allocator.free(t);
            try file.writeAll(t);
        } else {
            try file.writeAll(",");
        }

        // status
        if (c.sqlite3_column_text(stmt, 4)) |status| {
            const status_str = std.mem.span(status);
            const escaped = try escapeCSV(allocator, status_str);
            defer allocator.free(escaped);
            const s = try std.fmt.allocPrint(allocator, "{s},", .{escaped});
            defer allocator.free(s);
            try file.writeAll(s);
        } else {
            try file.writeAll(",");
        }

        // pid
        const pid = c.sqlite3_column_int(stmt, 5);
        const pid_str = try std.fmt.allocPrint(allocator, "{d}", .{pid});
        defer allocator.free(pid_str);
        try file.writeAll(pid_str);

        // raw_content (optional)
        if (options.include_raw) {
            if (c.sqlite3_column_text(stmt, 6)) |raw| {
                const raw_str = std.mem.span(raw);
                const escaped = try escapeCSV(allocator, raw_str);
                defer allocator.free(escaped);
                const r = try std.fmt.allocPrint(allocator, ",{s}", .{escaped});
                defer allocator.free(r);
                try file.writeAll(r);
            } else {
                try file.writeAll(",");
            }
        }

        try file.writeAll("\n");
        count += 1;
    }

    std.debug.print("✅ Exported {d} cognitive states to {s}\n", .{ count, options.output_file });
}

fn escapeCSV(allocator: std.mem.Allocator, value: []const u8) ![]const u8 {
    // Check if escaping is needed
    const needs_escape = std.mem.indexOf(u8, value, "\"") != null or
        std.mem.indexOf(u8, value, ",") != null or
        std.mem.indexOf(u8, value, "\n") != null;

    if (!needs_escape) {
        return try std.fmt.allocPrint(allocator, "\"{s}\"", .{value});
    }

    // Escape quotes by doubling them
    var result = std.ArrayList(u8).empty;
    defer result.deinit(allocator);

    try result.append(allocator, '"');
    for (value) |char| {
        if (char == '"') {
            try result.append(allocator, '"');
            try result.append(allocator, '"');
        } else {
            try result.append(allocator, char);
        }
    }
    try result.append(allocator, '"');

    return try result.toOwnedSlice(allocator);
}
