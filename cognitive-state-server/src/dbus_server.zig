const std = @import("std");
const c = @cImport({
    @cInclude("dbus/dbus.h");
});

const StateCache = @import("main.zig").StateCache;

pub const DBusServer = struct {
    conn: ?*c.DBusConnection,
    cache: *StateCache,
    allocator: std.mem.Allocator,

    const SERVICE_NAME = "org.jesternet.CognitiveOracle";
    const OBJECT_PATH = "/org/jesternet/CognitiveOracle";
    const INTERFACE_NAME = "org.jesternet.CognitiveOracle";

    pub fn init(allocator: std.mem.Allocator, cache: *StateCache) !DBusServer {
        var err: c.DBusError = undefined;
        c.dbus_error_init(&err);
        defer c.dbus_error_free(&err);

        // Connect to session bus
        const conn = c.dbus_bus_get(c.DBUS_BUS_SESSION, &err);
        if (c.dbus_error_is_set(&err) != 0) {
            std.debug.print("[D-Bus] Connection error: {s}\n", .{err.message});
            return error.DBusConnectionFailed;
        }

        if (conn == null) {
            return error.DBusConnectionFailed;
        }

        // Request service name
        const name_result = c.dbus_bus_request_name(
            conn,
            SERVICE_NAME,
            c.DBUS_NAME_FLAG_REPLACE_EXISTING,
            &err,
        );

        if (c.dbus_error_is_set(&err) != 0) {
            std.debug.print("[D-Bus] Request name error: {s}\n", .{err.message});
            return error.DBusRequestNameFailed;
        }

        if (name_result != c.DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER) {
            std.debug.print("[D-Bus] Not primary owner: {d}\n", .{name_result});
            return error.DBusRequestNameFailed;
        }

        std.debug.print("[D-Bus] ✓ Registered as {s}\n", .{SERVICE_NAME});

        return DBusServer{
            .conn = conn,
            .cache = cache,
            .allocator = allocator,
        };
    }

    pub fn processMessages(self: *DBusServer) !void {
        // Non-blocking dispatch
        _ = c.dbus_connection_read_write_dispatch(self.conn, 0);

        // Pop and handle messages
        while (c.dbus_connection_pop_message(self.conn)) |msg| {
            defer c.dbus_message_unref(msg);
            try self.handleMessage(msg);
        }
    }

    fn handleMessage(self: *DBusServer, msg: *c.DBusMessage) !void {
        // Check if it's a method call for our interface
        if (c.dbus_message_is_method_call(msg, INTERFACE_NAME, "GetCurrentState") != 0) {
            try self.handleGetCurrentState(msg);
        } else if (c.dbus_message_is_method_call(msg, INTERFACE_NAME, "GetStateForPid") != 0) {
            try self.handleGetStateForPid(msg);
        } else if (c.dbus_message_is_method_call(msg, INTERFACE_NAME, "GetRecentStates") != 0) {
            try self.handleGetRecentStates(msg);
        } else if (c.dbus_message_is_method_call(msg, INTERFACE_NAME, "GetAllPids") != 0) {
            try self.handleGetAllPids(msg);
        }
    }

    fn handleGetCurrentState(self: *DBusServer, msg: *c.DBusMessage) !void {
        // Get the most recent state from any PID
        const recent = self.cache.getRecentStates(1);

        const reply = c.dbus_message_new_method_return(msg);
        defer c.dbus_message_unref(reply);

        if (recent.len > 0) {
            const state = recent[0];
            var iter: c.DBusMessageIter = undefined;
            c.dbus_message_iter_init_append(reply, &iter);

            // Append state_type string
            const state_cstr = try self.allocator.dupeZ(u8, state.state_type);
            defer self.allocator.free(state_cstr);

            const ptr: [*c]const u8 = state_cstr.ptr;
            _ = c.dbus_message_iter_append_basic(&iter, c.DBUS_TYPE_STRING, &ptr);
        } else {
            // Return "Unknown" if no states
            const unknown = "Unknown";
            const ptr: [*c]const u8 = unknown.ptr;
            var iter: c.DBusMessageIter = undefined;
            c.dbus_message_iter_init_append(reply, &iter);
            _ = c.dbus_message_iter_append_basic(&iter, c.DBUS_TYPE_STRING, &ptr);
        }

        _ = c.dbus_connection_send(self.conn, reply, null);
        c.dbus_connection_flush(self.conn);
    }

    fn handleGetStateForPid(self: *DBusServer, msg: *c.DBusMessage) !void {
        // Get PID argument
        var iter: c.DBusMessageIter = undefined;
        if (c.dbus_message_iter_init(msg, &iter) == 0) {
            try self.sendError(msg, "Invalid arguments");
            return;
        }

        var pid: u32 = 0;
        c.dbus_message_iter_get_basic(&iter, &pid);

        const reply = c.dbus_message_new_method_return(msg);
        defer c.dbus_message_unref(reply);

        if (self.cache.getStateForPid(pid)) |state| {
            var reply_iter: c.DBusMessageIter = undefined;
            c.dbus_message_iter_init_append(reply, &reply_iter);

            const state_cstr = try self.allocator.dupeZ(u8, state.state_type);
            defer self.allocator.free(state_cstr);

            const ptr: [*c]const u8 = state_cstr.ptr;
            _ = c.dbus_message_iter_append_basic(&reply_iter, c.DBUS_TYPE_STRING, &ptr);
        } else {
            var reply_iter: c.DBusMessageIter = undefined;
            c.dbus_message_iter_init_append(reply, &reply_iter);

            const unknown = "Unknown";
            const ptr: [*c]const u8 = unknown.ptr;
            _ = c.dbus_message_iter_append_basic(&reply_iter, c.DBUS_TYPE_STRING, &ptr);
        }

        _ = c.dbus_connection_send(self.conn, reply, null);
        c.dbus_connection_flush(self.conn);
    }

    fn handleGetRecentStates(self: *DBusServer, msg: *c.DBusMessage) !void {
        // Get limit argument
        var iter: c.DBusMessageIter = undefined;
        if (c.dbus_message_iter_init(msg, &iter) == 0) {
            try self.sendError(msg, "Invalid arguments");
            return;
        }

        var limit: i32 = 0;
        c.dbus_message_iter_get_basic(&iter, &limit);

        const recent = self.cache.getRecentStates(@intCast(limit));

        const reply = c.dbus_message_new_method_return(msg);
        defer c.dbus_message_unref(reply);

        var reply_iter: c.DBusMessageIter = undefined;
        c.dbus_message_iter_init_append(reply, &reply_iter);

        // Build JSON array string
        var json_buf = std.ArrayList(u8).init(self.allocator);
        defer json_buf.deinit();

        try json_buf.appendSlice("[");
        for (recent, 0..) |state, i| {
            if (i > 0) try json_buf.appendSlice(",");

            try json_buf.appendSlice("{\"pid\":");
            var num_buf: [20]u8 = undefined;
            const num_str = try std.fmt.bufPrint(&num_buf, "{d}", .{state.pid});
            try json_buf.appendSlice(num_str);

            try json_buf.appendSlice(",\"state\":\"");
            try json_buf.appendSlice(state.state_type);
            try json_buf.appendSlice("\"}");
        }
        try json_buf.appendSlice("]");

        const json_cstr = try self.allocator.dupeZ(u8, json_buf.items);
        defer self.allocator.free(json_cstr);

        const ptr: [*c]const u8 = json_cstr.ptr;
        _ = c.dbus_message_iter_append_basic(&reply_iter, c.DBUS_TYPE_STRING, &ptr);

        _ = c.dbus_connection_send(self.conn, reply, null);
        c.dbus_connection_flush(self.conn);
    }

    fn handleGetAllPids(self: *DBusServer, msg: *c.DBusMessage) !void {
        const reply = c.dbus_message_new_method_return(msg);
        defer c.dbus_message_unref(reply);

        // Build JSON array of all PIDs
        var json_buf = std.ArrayList(u8).init(self.allocator);
        defer json_buf.deinit();

        try json_buf.appendSlice("[");

        var it = self.cache.states_by_pid.keyIterator();
        var first = true;
        while (it.next()) |pid| {
            if (!first) try json_buf.appendSlice(",");
            first = false;

            var num_buf: [20]u8 = undefined;
            const num_str = try std.fmt.bufPrint(&num_buf, "{d}", .{pid.*});
            try json_buf.appendSlice(num_str);
        }
        try json_buf.appendSlice("]");

        const json_cstr = try self.allocator.dupeZ(u8, json_buf.items);
        defer self.allocator.free(json_cstr);

        var reply_iter: c.DBusMessageIter = undefined;
        c.dbus_message_iter_init_append(reply, &reply_iter);

        const ptr: [*c]const u8 = json_cstr.ptr;
        _ = c.dbus_message_iter_append_basic(&reply_iter, c.DBUS_TYPE_STRING, &ptr);

        _ = c.dbus_connection_send(self.conn, reply, null);
        c.dbus_connection_flush(self.conn);
    }

    fn sendError(self: *DBusServer, msg: *c.DBusMessage, error_msg: [*:0]const u8) !void {
        const reply = c.dbus_message_new_error(msg, "org.jesternet.CognitiveOracle.Error", error_msg);
        defer c.dbus_message_unref(reply);

        _ = c.dbus_connection_send(self.conn, reply, null);
        c.dbus_connection_flush(self.conn);
    }

    pub fn deinit(self: *DBusServer) void {
        if (self.conn) |conn| {
            c.dbus_connection_unref(conn);
        }
    }
};
