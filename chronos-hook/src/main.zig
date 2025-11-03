const std = @import("std");
const builtin = @import("builtin");

const CHRONOS_STAMP_PATH = "/usr/local/bin/chronos-stamp";
const GET_COGNITIVE_STATE_PATH = "/usr/local/bin/get-cognitive-state";
const AGENT_ID = "claude-code";

pub fn main() !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Check if we're in a git repository
    if (!try isGitRepository(allocator)) {
        return 0;
    }

    // Get environment variables
    const tool_input = std.posix.getenv("CLAUDE_TOOL_INPUT");
    const claude_pid_str = std.posix.getenv("CLAUDE_PID");

    // Extract tool description from JSON if available
    var tool_description: ?[]const u8 = null;
    if (tool_input) |input| {
        tool_description = try extractToolDescription(allocator, input);
    }
    defer if (tool_description) |desc| allocator.free(desc);

    // Get Claude PID
    var pid: ?u32 = null;
    if (claude_pid_str) |pid_str| {
        pid = std.fmt.parseInt(u32, pid_str, 10) catch null;
    }
    if (pid == null) {
        // Fallback: try to find Claude process
        pid = try findClaudePid(allocator);
    }

    // Get cognitive state
    const cognitive_state = try getCognitiveState(allocator, pid);
    defer allocator.free(cognitive_state);

    // Generate CHRONOS timestamp
    const chronos_output = try generateChronosTimestamp(allocator);
    defer allocator.free(chronos_output);

    // Build commit message
    var commit_msg = std.ArrayList(u8).empty;
    defer commit_msg.deinit(allocator);

    // Inject cognitive state into CHRONOS output
    // Replace "::::TICK" with "::<state>::TICK"
    if (std.mem.indexOf(u8, chronos_output, "::::TICK")) |pos| {
        try commit_msg.appendSlice(allocator, chronos_output[0..pos]);
        try commit_msg.appendSlice(allocator, "::");
        try commit_msg.appendSlice(allocator, cognitive_state);
        try commit_msg.appendSlice(allocator, "::");
        try commit_msg.appendSlice(allocator, chronos_output[pos + 4 ..]);
    } else {
        try commit_msg.appendSlice(allocator, chronos_output);
    }

    // Append tool description if available
    if (tool_description) |desc| {
        try commit_msg.appendSlice(allocator, " - ");
        try commit_msg.appendSlice(allocator, desc);
    }

    // Stage all changes
    _ = try runCommand(allocator, &[_][]const u8{ "git", "add", "." });

    // Check if there are changes to commit
    const diff_result = try runCommand(allocator, &[_][]const u8{ "git", "diff", "--cached", "--quiet" });
    if (diff_result.exit_code == 0) {
        // No changes to commit
        return 0;
    }

    // Commit with message
    const commit_result = try runCommand(allocator, &[_][]const u8{ "git", "commit", "-m", commit_msg.items });

    return if (commit_result.exit_code == 0) 0 else 1;
}

fn isGitRepository(allocator: std.mem.Allocator) !bool {
    const result = try runCommand(allocator, &[_][]const u8{ "git", "rev-parse", "--git-dir" });
    return result.exit_code == 0;
}

fn extractToolDescription(allocator: std.mem.Allocator, json_input: []const u8) !?[]const u8 {
    // Simple JSON parsing - look for "description":"..."
    const needle = "\"description\":\"";
    const start_pos = std.mem.indexOf(u8, json_input, needle) orelse return null;
    const value_start = start_pos + needle.len;

    // Find closing quote
    const end_pos = std.mem.indexOfPos(u8, json_input, value_start, "\"") orelse return null;

    const description = json_input[value_start..end_pos];
    return try allocator.dupe(u8, description);
}

fn findClaudePid(allocator: std.mem.Allocator) !?u32 {
    const result = try runCommand(allocator, &[_][]const u8{ "pgrep", "-f", "claude" });
    defer result.deinit();

    if (result.exit_code != 0 or result.stdout.len == 0) {
        return null;
    }

    // Get first line
    const newline_pos = std.mem.indexOf(u8, result.stdout, "\n") orelse result.stdout.len;
    const pid_str = std.mem.trim(u8, result.stdout[0..newline_pos], " \t\n\r");

    return std.fmt.parseInt(u32, pid_str, 10) catch null;
}

fn getCognitiveState(allocator: std.mem.Allocator, pid: ?u32) ![]const u8 {
    var args = std.ArrayList([]const u8).empty;
    defer args.deinit(allocator);

    try args.append(allocator, GET_COGNITIVE_STATE_PATH);

    if (pid) |p| {
        const pid_str = try std.fmt.allocPrint(allocator, "{d}", .{p});
        defer allocator.free(pid_str);
        try args.append(allocator, pid_str);
    }

    const result = try runCommand(allocator, args.items);
    defer result.deinit();

    if (result.exit_code == 0 and result.stdout.len > 0) {
        // Trim whitespace
        const state = std.mem.trim(u8, result.stdout, " \t\n\r");
        if (state.len > 0) {
            return try allocator.dupe(u8, state);
        }
    }

    // Fallback
    return try allocator.dupe(u8, "Active");
}

fn generateChronosTimestamp(allocator: std.mem.Allocator) ![]const u8 {
    const result = try runCommand(allocator, &[_][]const u8{ CHRONOS_STAMP_PATH, AGENT_ID, "tool-completion" });

    if (result.exit_code == 0 and result.stdout.len > 0) {
        // Extract [CHRONOS] line
        if (std.mem.indexOf(u8, result.stdout, "[CHRONOS]")) |start| {
            const newline_pos = std.mem.indexOfPos(u8, result.stdout, start, "\n") orelse result.stdout.len;
            const chronos_line = std.mem.trim(u8, result.stdout[start..newline_pos], " \t\n\r");
            return try allocator.dupe(u8, chronos_line);
        }
    }

    // Fallback: generate manual timestamp
    const timestamp = std.time.nanoTimestamp();
    return try std.fmt.allocPrint(allocator, "[FALLBACK] {d}::{s}::::tool-completion", .{ timestamp, AGENT_ID });
}

const CommandResult = struct {
    exit_code: u8,
    stdout: []const u8,
    allocator: std.mem.Allocator,

    pub fn deinit(self: *CommandResult) void {
        self.allocator.free(self.stdout);
    }
};

fn runCommand(allocator: std.mem.Allocator, argv: []const []const u8) !CommandResult {
    var child = std.process.Child.init(argv, allocator);
    child.stdout_behavior = .Pipe;
    child.stderr_behavior = .Ignore;

    try child.spawn();

    // Read stdout using buffer
    var buf: [1024 * 1024]u8 = undefined;
    const bytes_read = try child.stdout.?.readAll(&buf);
    const stdout = try allocator.dupe(u8, buf[0..bytes_read]);

    const term = try child.wait();

    const exit_code: u8 = switch (term) {
        .Exited => |code| @intCast(code),
        else => 1,
    };

    return CommandResult{
        .exit_code = exit_code,
        .stdout = stdout,
        .allocator = allocator,
    };
}
