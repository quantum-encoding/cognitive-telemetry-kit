pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;

pub const struct___va_list_tag_1 = extern struct {
    unnamed_0: c_uint = 0,
    unnamed_1: c_uint = 0,
    unnamed_2: ?*anyopaque = null,
    unnamed_3: ?*anyopaque = null,
};
pub const __builtin_va_list = [1]struct___va_list_tag_1;
pub const va_list = __builtin_va_list;
pub const __gnuc_va_list = __builtin_va_list;
pub const sqlite3_version: [*c]const u8 = @extern([*c]const u8, .{
    .name = "sqlite3_version",
});
pub extern fn sqlite3_libversion() [*c]const u8;
pub extern fn sqlite3_sourceid() [*c]const u8;
pub extern fn sqlite3_libversion_number() c_int;
pub extern fn sqlite3_compileoption_used(zOptName: [*c]const u8) c_int;
pub extern fn sqlite3_compileoption_get(N: c_int) [*c]const u8;
pub extern fn sqlite3_threadsafe() c_int;
pub const struct_sqlite3 = opaque {
    pub const close = sqlite3_close;
    pub const v2 = sqlite3_close_v2;
    pub const exec = sqlite3_exec;
    pub const config = sqlite3_db_config;
    pub const codes = sqlite3_extended_result_codes;
    pub const rowid = sqlite3_last_insert_rowid;
    pub const rowid1 = sqlite3_set_last_insert_rowid;
    pub const changes = sqlite3_changes;
    pub const changes64 = sqlite3_changes64;
    pub const changes1 = sqlite3_total_changes;
    pub const changes641 = sqlite3_total_changes64;
    pub const interrupt = sqlite3_interrupt;
    pub const interrupted = sqlite3_is_interrupted;
    pub const handler = sqlite3_busy_handler;
    pub const timeout = sqlite3_busy_timeout;
    pub const timeout1 = sqlite3_setlk_timeout;
    pub const table = sqlite3_get_table;
    pub const authorizer = sqlite3_set_authorizer;
    pub const trace = sqlite3_trace;
    pub const profile = sqlite3_profile;
    pub const v21 = sqlite3_trace_v2;
    pub const handler1 = sqlite3_progress_handler;
    pub const errcode = sqlite3_errcode;
    pub const errcode1 = sqlite3_extended_errcode;
    pub const errmsg = sqlite3_errmsg;
    pub const errmsg16 = sqlite3_errmsg16;
    pub const offset = sqlite3_error_offset;
    pub const limit = sqlite3_limit;
    pub const prepare = sqlite3_prepare;
    pub const v22 = sqlite3_prepare_v2;
    pub const v3 = sqlite3_prepare_v3;
    pub const prepare16 = sqlite3_prepare16;
    pub const v23 = sqlite3_prepare16_v2;
    pub const v31 = sqlite3_prepare16_v3;
    pub const function = sqlite3_create_function;
    pub const function16 = sqlite3_create_function16;
    pub const v24 = sqlite3_create_function_v2;
    pub const function1 = sqlite3_create_window_function;
    pub const clientdata = sqlite3_get_clientdata;
    pub const clientdata1 = sqlite3_set_clientdata;
    pub const collation = sqlite3_create_collation;
    pub const v25 = sqlite3_create_collation_v2;
    pub const collation16 = sqlite3_create_collation16;
    pub const needed = sqlite3_collation_needed;
    pub const needed16 = sqlite3_collation_needed16;
    pub const autocommit = sqlite3_get_autocommit;
    pub const name = sqlite3_db_name;
    pub const filename = sqlite3_db_filename;
    pub const readonly = sqlite3_db_readonly;
    pub const state = sqlite3_txn_state;
    pub const stmt = sqlite3_next_stmt;
    pub const hook = sqlite3_commit_hook;
    pub const hook1 = sqlite3_rollback_hook;
    pub const pages = sqlite3_autovacuum_pages;
    pub const hook2 = sqlite3_update_hook;
    pub const memory = sqlite3_db_release_memory;
    pub const metadata = sqlite3_table_column_metadata;
    pub const extension = sqlite3_load_extension;
    pub const extension1 = sqlite3_enable_load_extension;
    pub const module = sqlite3_create_module;
    pub const v26 = sqlite3_create_module_v2;
    pub const modules = sqlite3_drop_modules;
    pub const vtab = sqlite3_declare_vtab;
    pub const function2 = sqlite3_overload_function;
    pub const open = sqlite3_blob_open;
    pub const mutex = sqlite3_db_mutex;
    pub const control = sqlite3_file_control;
    pub const new = sqlite3_str_new;
    pub const status = sqlite3_db_status;
    pub const init = sqlite3_backup_init;
    pub const notify = sqlite3_unlock_notify;
    pub const hook3 = sqlite3_wal_hook;
    pub const autocheckpoint = sqlite3_wal_autocheckpoint;
    pub const checkpoint = sqlite3_wal_checkpoint;
    pub const v27 = sqlite3_wal_checkpoint_v2;
    pub const config1 = sqlite3_vtab_config;
    pub const conflict = sqlite3_vtab_on_conflict;
    pub const cacheflush = sqlite3_db_cacheflush;
    pub const errno = sqlite3_system_errno;
    pub const get = sqlite3_snapshot_get;
    pub const open1 = sqlite3_snapshot_open;
    pub const recover = sqlite3_snapshot_recover;
    pub const serialize = sqlite3_serialize;
    pub const deserialize = sqlite3_deserialize;
    pub const callback = sqlite3_rtree_geometry_callback;
    pub const callback1 = sqlite3_rtree_query_callback;
};
pub const sqlite3 = struct_sqlite3;
pub const sqlite_int64 = c_longlong;
pub const sqlite_uint64 = c_ulonglong;
pub const sqlite3_int64 = sqlite_int64;
pub const sqlite3_uint64 = sqlite_uint64;
pub extern fn sqlite3_close(?*sqlite3) c_int;
pub extern fn sqlite3_close_v2(?*sqlite3) c_int;
pub const sqlite3_callback = ?*const fn (?*anyopaque, c_int, [*c][*c]u8, [*c][*c]u8) callconv(.c) c_int;
pub extern fn sqlite3_exec(?*sqlite3, sql: [*c]const u8, callback: ?*const fn (?*anyopaque, c_int, [*c][*c]u8, [*c][*c]u8) callconv(.c) c_int, ?*anyopaque, errmsg: [*c][*c]u8) c_int;
pub const struct_sqlite3_io_methods = extern struct {
    iVersion: c_int = 0,
    xClose: ?*const fn ([*c]sqlite3_file) callconv(.c) c_int = null,
    xRead: ?*const fn ([*c]sqlite3_file, ?*anyopaque, iAmt: c_int, iOfst: sqlite3_int64) callconv(.c) c_int = null,
    xWrite: ?*const fn ([*c]sqlite3_file, ?*const anyopaque, iAmt: c_int, iOfst: sqlite3_int64) callconv(.c) c_int = null,
    xTruncate: ?*const fn ([*c]sqlite3_file, size: sqlite3_int64) callconv(.c) c_int = null,
    xSync: ?*const fn ([*c]sqlite3_file, flags: c_int) callconv(.c) c_int = null,
    xFileSize: ?*const fn ([*c]sqlite3_file, pSize: [*c]sqlite3_int64) callconv(.c) c_int = null,
    xLock: ?*const fn ([*c]sqlite3_file, c_int) callconv(.c) c_int = null,
    xUnlock: ?*const fn ([*c]sqlite3_file, c_int) callconv(.c) c_int = null,
    xCheckReservedLock: ?*const fn ([*c]sqlite3_file, pResOut: [*c]c_int) callconv(.c) c_int = null,
    xFileControl: ?*const fn ([*c]sqlite3_file, op: c_int, pArg: ?*anyopaque) callconv(.c) c_int = null,
    xSectorSize: ?*const fn ([*c]sqlite3_file) callconv(.c) c_int = null,
    xDeviceCharacteristics: ?*const fn ([*c]sqlite3_file) callconv(.c) c_int = null,
    xShmMap: ?*const fn ([*c]sqlite3_file, iPg: c_int, pgsz: c_int, c_int, [*c]?*volatile anyopaque) callconv(.c) c_int = null,
    xShmLock: ?*const fn ([*c]sqlite3_file, offset: c_int, n: c_int, flags: c_int) callconv(.c) c_int = null,
    xShmBarrier: ?*const fn ([*c]sqlite3_file) callconv(.c) void = null,
    xShmUnmap: ?*const fn ([*c]sqlite3_file, deleteFlag: c_int) callconv(.c) c_int = null,
    xFetch: ?*const fn ([*c]sqlite3_file, iOfst: sqlite3_int64, iAmt: c_int, pp: [*c]?*anyopaque) callconv(.c) c_int = null,
    xUnfetch: ?*const fn ([*c]sqlite3_file, iOfst: sqlite3_int64, p: ?*anyopaque) callconv(.c) c_int = null,
};
pub const struct_sqlite3_file = extern struct {
    pMethods: [*c]const struct_sqlite3_io_methods = null,
};
pub const sqlite3_file = struct_sqlite3_file;
pub const sqlite3_io_methods = struct_sqlite3_io_methods;
pub const struct_sqlite3_mutex = opaque {
    pub const free = sqlite3_mutex_free;
    pub const enter = sqlite3_mutex_enter;
    pub const @"try" = sqlite3_mutex_try;
    pub const leave = sqlite3_mutex_leave;
    pub const held = sqlite3_mutex_held;
    pub const notheld = sqlite3_mutex_notheld;
};
pub const sqlite3_mutex = struct_sqlite3_mutex;
pub const struct_sqlite3_api_routines = opaque {};
pub const sqlite3_api_routines = struct_sqlite3_api_routines;
pub const sqlite3_filename = [*c]const u8;
pub const sqlite3_syscall_ptr = ?*const fn () callconv(.c) void;
pub const struct_sqlite3_vfs = extern struct {
    iVersion: c_int = 0,
    szOsFile: c_int = 0,
    mxPathname: c_int = 0,
    pNext: [*c]sqlite3_vfs = null,
    zName: [*c]const u8 = null,
    pAppData: ?*anyopaque = null,
    xOpen: ?*const fn ([*c]sqlite3_vfs, zName: sqlite3_filename, [*c]sqlite3_file, flags: c_int, pOutFlags: [*c]c_int) callconv(.c) c_int = null,
    xDelete: ?*const fn ([*c]sqlite3_vfs, zName: [*c]const u8, syncDir: c_int) callconv(.c) c_int = null,
    xAccess: ?*const fn ([*c]sqlite3_vfs, zName: [*c]const u8, flags: c_int, pResOut: [*c]c_int) callconv(.c) c_int = null,
    xFullPathname: ?*const fn ([*c]sqlite3_vfs, zName: [*c]const u8, nOut: c_int, zOut: [*c]u8) callconv(.c) c_int = null,
    xDlOpen: ?*const fn ([*c]sqlite3_vfs, zFilename: [*c]const u8) callconv(.c) ?*anyopaque = null,
    xDlError: ?*const fn ([*c]sqlite3_vfs, nByte: c_int, zErrMsg: [*c]u8) callconv(.c) void = null,
    xDlSym: ?*const fn ([*c]sqlite3_vfs, ?*anyopaque, zSymbol: [*c]const u8) callconv(.c) ?*const fn () callconv(.c) void = null,
    xDlClose: ?*const fn ([*c]sqlite3_vfs, ?*anyopaque) callconv(.c) void = null,
    xRandomness: ?*const fn ([*c]sqlite3_vfs, nByte: c_int, zOut: [*c]u8) callconv(.c) c_int = null,
    xSleep: ?*const fn ([*c]sqlite3_vfs, microseconds: c_int) callconv(.c) c_int = null,
    xCurrentTime: ?*const fn ([*c]sqlite3_vfs, [*c]f64) callconv(.c) c_int = null,
    xGetLastError: ?*const fn ([*c]sqlite3_vfs, c_int, [*c]u8) callconv(.c) c_int = null,
    xCurrentTimeInt64: ?*const fn ([*c]sqlite3_vfs, [*c]sqlite3_int64) callconv(.c) c_int = null,
    xSetSystemCall: ?*const fn ([*c]sqlite3_vfs, zName: [*c]const u8, sqlite3_syscall_ptr) callconv(.c) c_int = null,
    xGetSystemCall: ?*const fn ([*c]sqlite3_vfs, zName: [*c]const u8) callconv(.c) sqlite3_syscall_ptr = null,
    xNextSystemCall: ?*const fn ([*c]sqlite3_vfs, zName: [*c]const u8) callconv(.c) [*c]const u8 = null,
    pub const register = sqlite3_vfs_register;
    pub const unregister = sqlite3_vfs_unregister;
};
pub const sqlite3_vfs = struct_sqlite3_vfs;
pub extern fn sqlite3_initialize() c_int;
pub extern fn sqlite3_shutdown() c_int;
pub extern fn sqlite3_os_init() c_int;
pub extern fn sqlite3_os_end() c_int;
pub extern fn sqlite3_config(c_int, ...) c_int;
pub extern fn sqlite3_db_config(?*sqlite3, op: c_int, ...) c_int;
pub const struct_sqlite3_mem_methods = extern struct {
    xMalloc: ?*const fn (c_int) callconv(.c) ?*anyopaque = null,
    xFree: ?*const fn (?*anyopaque) callconv(.c) void = null,
    xRealloc: ?*const fn (?*anyopaque, c_int) callconv(.c) ?*anyopaque = null,
    xSize: ?*const fn (?*anyopaque) callconv(.c) c_int = null,
    xRoundup: ?*const fn (c_int) callconv(.c) c_int = null,
    xInit: ?*const fn (?*anyopaque) callconv(.c) c_int = null,
    xShutdown: ?*const fn (?*anyopaque) callconv(.c) void = null,
    pAppData: ?*anyopaque = null,
};
pub const sqlite3_mem_methods = struct_sqlite3_mem_methods;
pub extern fn sqlite3_extended_result_codes(?*sqlite3, onoff: c_int) c_int;
pub extern fn sqlite3_last_insert_rowid(?*sqlite3) sqlite3_int64;
pub extern fn sqlite3_set_last_insert_rowid(?*sqlite3, sqlite3_int64) void;
pub extern fn sqlite3_changes(?*sqlite3) c_int;
pub extern fn sqlite3_changes64(?*sqlite3) sqlite3_int64;
pub extern fn sqlite3_total_changes(?*sqlite3) c_int;
pub extern fn sqlite3_total_changes64(?*sqlite3) sqlite3_int64;
pub extern fn sqlite3_interrupt(?*sqlite3) void;
pub extern fn sqlite3_is_interrupted(?*sqlite3) c_int;
pub extern fn sqlite3_complete(sql: [*c]const u8) c_int;
pub extern fn sqlite3_complete16(sql: ?*const anyopaque) c_int;
pub extern fn sqlite3_busy_handler(?*sqlite3, ?*const fn (?*anyopaque, c_int) callconv(.c) c_int, ?*anyopaque) c_int;
pub extern fn sqlite3_busy_timeout(?*sqlite3, ms: c_int) c_int;
pub extern fn sqlite3_setlk_timeout(?*sqlite3, ms: c_int, flags: c_int) c_int;
pub extern fn sqlite3_get_table(db: ?*sqlite3, zSql: [*c]const u8, pazResult: [*c][*c][*c]u8, pnRow: [*c]c_int, pnColumn: [*c]c_int, pzErrmsg: [*c][*c]u8) c_int;
pub extern fn sqlite3_free_table(result: [*c][*c]u8) void;
pub extern fn sqlite3_mprintf([*c]const u8, ...) [*c]u8;
pub extern fn sqlite3_vmprintf([*c]const u8, [*c]struct___va_list_tag_1) [*c]u8;
pub extern fn sqlite3_snprintf(c_int, [*c]u8, [*c]const u8, ...) [*c]u8;
pub extern fn sqlite3_vsnprintf(c_int, [*c]u8, [*c]const u8, [*c]struct___va_list_tag_1) [*c]u8;
pub extern fn sqlite3_malloc(c_int) ?*anyopaque;
pub extern fn sqlite3_malloc64(sqlite3_uint64) ?*anyopaque;
pub extern fn sqlite3_realloc(?*anyopaque, c_int) ?*anyopaque;
pub extern fn sqlite3_realloc64(?*anyopaque, sqlite3_uint64) ?*anyopaque;
pub extern fn sqlite3_free(?*anyopaque) void;
pub extern fn sqlite3_msize(?*anyopaque) sqlite3_uint64;
pub extern fn sqlite3_memory_used() sqlite3_int64;
pub extern fn sqlite3_memory_highwater(resetFlag: c_int) sqlite3_int64;
pub extern fn sqlite3_randomness(N: c_int, P: ?*anyopaque) void;
pub extern fn sqlite3_set_authorizer(?*sqlite3, xAuth: ?*const fn (?*anyopaque, c_int, [*c]const u8, [*c]const u8, [*c]const u8, [*c]const u8) callconv(.c) c_int, pUserData: ?*anyopaque) c_int;
pub extern fn sqlite3_trace(?*sqlite3, xTrace: ?*const fn (?*anyopaque, [*c]const u8) callconv(.c) void, ?*anyopaque) ?*anyopaque;
pub extern fn sqlite3_profile(?*sqlite3, xProfile: ?*const fn (?*anyopaque, [*c]const u8, sqlite3_uint64) callconv(.c) void, ?*anyopaque) ?*anyopaque;
pub extern fn sqlite3_trace_v2(?*sqlite3, uMask: c_uint, xCallback: ?*const fn (c_uint, ?*anyopaque, ?*anyopaque, ?*anyopaque) callconv(.c) c_int, pCtx: ?*anyopaque) c_int;
pub extern fn sqlite3_progress_handler(?*sqlite3, c_int, ?*const fn (?*anyopaque) callconv(.c) c_int, ?*anyopaque) void;
pub extern fn sqlite3_open(filename: [*c]const u8, ppDb: [*c]?*sqlite3) c_int;
pub extern fn sqlite3_open16(filename: ?*const anyopaque, ppDb: [*c]?*sqlite3) c_int;
pub extern fn sqlite3_open_v2(filename: [*c]const u8, ppDb: [*c]?*sqlite3, flags: c_int, zVfs: [*c]const u8) c_int;
pub extern fn sqlite3_uri_parameter(z: sqlite3_filename, zParam: [*c]const u8) [*c]const u8;
pub extern fn sqlite3_uri_boolean(z: sqlite3_filename, zParam: [*c]const u8, bDefault: c_int) c_int;
pub extern fn sqlite3_uri_int64(sqlite3_filename, [*c]const u8, sqlite3_int64) sqlite3_int64;
pub extern fn sqlite3_uri_key(z: sqlite3_filename, N: c_int) [*c]const u8;
pub extern fn sqlite3_filename_database(sqlite3_filename) [*c]const u8;
pub extern fn sqlite3_filename_journal(sqlite3_filename) [*c]const u8;
pub extern fn sqlite3_filename_wal(sqlite3_filename) [*c]const u8;
pub extern fn sqlite3_database_file_object([*c]const u8) [*c]sqlite3_file;
pub extern fn sqlite3_create_filename(zDatabase: [*c]const u8, zJournal: [*c]const u8, zWal: [*c]const u8, nParam: c_int, azParam: [*c][*c]const u8) sqlite3_filename;
pub extern fn sqlite3_free_filename(sqlite3_filename) void;
pub extern fn sqlite3_errcode(db: ?*sqlite3) c_int;
pub extern fn sqlite3_extended_errcode(db: ?*sqlite3) c_int;
pub extern fn sqlite3_errmsg(?*sqlite3) [*c]const u8;
pub extern fn sqlite3_errmsg16(?*sqlite3) ?*const anyopaque;
pub extern fn sqlite3_errstr(c_int) [*c]const u8;
pub extern fn sqlite3_error_offset(db: ?*sqlite3) c_int;
pub const struct_sqlite3_stmt = opaque {
    pub const sql = sqlite3_sql;
    pub const sql1 = sqlite3_expanded_sql;
    pub const readonly = sqlite3_stmt_readonly;
    pub const isexplain = sqlite3_stmt_isexplain;
    pub const explain = sqlite3_stmt_explain;
    pub const busy = sqlite3_stmt_busy;
    pub const blob = sqlite3_bind_blob;
    pub const blob64 = sqlite3_bind_blob64;
    pub const double = sqlite3_bind_double;
    pub const int = sqlite3_bind_int;
    pub const int64 = sqlite3_bind_int64;
    pub const @"null" = sqlite3_bind_null;
    pub const text = sqlite3_bind_text;
    pub const text16 = sqlite3_bind_text16;
    pub const text64 = sqlite3_bind_text64;
    pub const value = sqlite3_bind_value;
    pub const pointer = sqlite3_bind_pointer;
    pub const zeroblob = sqlite3_bind_zeroblob;
    pub const zeroblob64 = sqlite3_bind_zeroblob64;
    pub const count = sqlite3_bind_parameter_count;
    pub const name = sqlite3_bind_parameter_name;
    pub const index = sqlite3_bind_parameter_index;
    pub const bindings = sqlite3_clear_bindings;
    pub const count1 = sqlite3_column_count;
    pub const name1 = sqlite3_column_name;
    pub const name16 = sqlite3_column_name16;
    pub const name2 = sqlite3_column_database_name;
    pub const name161 = sqlite3_column_database_name16;
    pub const name3 = sqlite3_column_table_name;
    pub const name162 = sqlite3_column_table_name16;
    pub const name4 = sqlite3_column_origin_name;
    pub const name163 = sqlite3_column_origin_name16;
    pub const decltype = sqlite3_column_decltype;
    pub const decltype16 = sqlite3_column_decltype16;
    pub const step = sqlite3_step;
    pub const count2 = sqlite3_data_count;
    pub const blob1 = sqlite3_column_blob;
    pub const double1 = sqlite3_column_double;
    pub const int1 = sqlite3_column_int;
    pub const int641 = sqlite3_column_int64;
    pub const text1 = sqlite3_column_text;
    pub const text161 = sqlite3_column_text16;
    pub const value1 = sqlite3_column_value;
    pub const bytes = sqlite3_column_bytes;
    pub const bytes16 = sqlite3_column_bytes16;
    pub const @"type" = sqlite3_column_type;
    pub const finalize = sqlite3_finalize;
    pub const reset = sqlite3_reset;
    pub const expired = sqlite3_expired;
    pub const bindings1 = sqlite3_transfer_bindings;
    pub const handle = sqlite3_db_handle;
    pub const status = sqlite3_stmt_status;
    pub const scanstatus = sqlite3_stmt_scanstatus;
    pub const v2 = sqlite3_stmt_scanstatus_v2;
    pub const reset1 = sqlite3_stmt_scanstatus_reset;
};
pub const sqlite3_stmt = struct_sqlite3_stmt;
pub extern fn sqlite3_limit(?*sqlite3, id: c_int, newVal: c_int) c_int;
pub extern fn sqlite3_prepare(db: ?*sqlite3, zSql: [*c]const u8, nByte: c_int, ppStmt: [*c]?*sqlite3_stmt, pzTail: [*c][*c]const u8) c_int;
pub extern fn sqlite3_prepare_v2(db: ?*sqlite3, zSql: [*c]const u8, nByte: c_int, ppStmt: [*c]?*sqlite3_stmt, pzTail: [*c][*c]const u8) c_int;
pub extern fn sqlite3_prepare_v3(db: ?*sqlite3, zSql: [*c]const u8, nByte: c_int, prepFlags: c_uint, ppStmt: [*c]?*sqlite3_stmt, pzTail: [*c][*c]const u8) c_int;
pub extern fn sqlite3_prepare16(db: ?*sqlite3, zSql: ?*const anyopaque, nByte: c_int, ppStmt: [*c]?*sqlite3_stmt, pzTail: [*c]?*const anyopaque) c_int;
pub extern fn sqlite3_prepare16_v2(db: ?*sqlite3, zSql: ?*const anyopaque, nByte: c_int, ppStmt: [*c]?*sqlite3_stmt, pzTail: [*c]?*const anyopaque) c_int;
pub extern fn sqlite3_prepare16_v3(db: ?*sqlite3, zSql: ?*const anyopaque, nByte: c_int, prepFlags: c_uint, ppStmt: [*c]?*sqlite3_stmt, pzTail: [*c]?*const anyopaque) c_int;
pub extern fn sqlite3_sql(pStmt: ?*sqlite3_stmt) [*c]const u8;
pub extern fn sqlite3_expanded_sql(pStmt: ?*sqlite3_stmt) [*c]u8;
pub extern fn sqlite3_stmt_readonly(pStmt: ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_stmt_isexplain(pStmt: ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_stmt_explain(pStmt: ?*sqlite3_stmt, eMode: c_int) c_int;
pub extern fn sqlite3_stmt_busy(?*sqlite3_stmt) c_int;
pub const struct_sqlite3_value = opaque {
    pub const blob = sqlite3_value_blob;
    pub const double = sqlite3_value_double;
    pub const int = sqlite3_value_int;
    pub const int64 = sqlite3_value_int64;
    pub const pointer = sqlite3_value_pointer;
    pub const text = sqlite3_value_text;
    pub const text16 = sqlite3_value_text16;
    pub const text16le = sqlite3_value_text16le;
    pub const text16be = sqlite3_value_text16be;
    pub const bytes = sqlite3_value_bytes;
    pub const bytes16 = sqlite3_value_bytes16;
    pub const @"type" = sqlite3_value_type;
    pub const type1 = sqlite3_value_numeric_type;
    pub const nochange = sqlite3_value_nochange;
    pub const frombind = sqlite3_value_frombind;
    pub const encoding = sqlite3_value_encoding;
    pub const subtype = sqlite3_value_subtype;
    pub const dup = sqlite3_value_dup;
    pub const free = sqlite3_value_free;
    pub const first = sqlite3_vtab_in_first;
    pub const next = sqlite3_vtab_in_next;
};
pub const sqlite3_value = struct_sqlite3_value;
pub const struct_sqlite3_context = opaque {
    pub const count = sqlite3_aggregate_count;
    pub const context = sqlite3_aggregate_context;
    pub const data = sqlite3_user_data;
    pub const handle = sqlite3_context_db_handle;
    pub const auxdata = sqlite3_get_auxdata;
    pub const auxdata1 = sqlite3_set_auxdata;
    pub const blob = sqlite3_result_blob;
    pub const blob64 = sqlite3_result_blob64;
    pub const double = sqlite3_result_double;
    pub const @"error" = sqlite3_result_error;
    pub const error16 = sqlite3_result_error16;
    pub const toobig = sqlite3_result_error_toobig;
    pub const nomem = sqlite3_result_error_nomem;
    pub const code = sqlite3_result_error_code;
    pub const int = sqlite3_result_int;
    pub const int64 = sqlite3_result_int64;
    pub const @"null" = sqlite3_result_null;
    pub const text = sqlite3_result_text;
    pub const text64 = sqlite3_result_text64;
    pub const text16 = sqlite3_result_text16;
    pub const text16le = sqlite3_result_text16le;
    pub const text16be = sqlite3_result_text16be;
    pub const value = sqlite3_result_value;
    pub const pointer = sqlite3_result_pointer;
    pub const zeroblob = sqlite3_result_zeroblob;
    pub const zeroblob64 = sqlite3_result_zeroblob64;
    pub const subtype = sqlite3_result_subtype;
    pub const nochange = sqlite3_vtab_nochange;
};
pub const sqlite3_context = struct_sqlite3_context;
pub extern fn sqlite3_bind_blob(?*sqlite3_stmt, c_int, ?*const anyopaque, n: c_int, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_bind_blob64(?*sqlite3_stmt, c_int, ?*const anyopaque, sqlite3_uint64, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_bind_double(?*sqlite3_stmt, c_int, f64) c_int;
pub extern fn sqlite3_bind_int(?*sqlite3_stmt, c_int, c_int) c_int;
pub extern fn sqlite3_bind_int64(?*sqlite3_stmt, c_int, sqlite3_int64) c_int;
pub extern fn sqlite3_bind_null(?*sqlite3_stmt, c_int) c_int;
pub extern fn sqlite3_bind_text(?*sqlite3_stmt, c_int, [*c]const u8, c_int, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_bind_text16(?*sqlite3_stmt, c_int, ?*const anyopaque, c_int, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_bind_text64(?*sqlite3_stmt, c_int, [*c]const u8, sqlite3_uint64, ?*const fn (?*anyopaque) callconv(.c) void, encoding: u8) c_int;
pub extern fn sqlite3_bind_value(?*sqlite3_stmt, c_int, ?*const sqlite3_value) c_int;
pub extern fn sqlite3_bind_pointer(?*sqlite3_stmt, c_int, ?*anyopaque, [*c]const u8, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_bind_zeroblob(?*sqlite3_stmt, c_int, n: c_int) c_int;
pub extern fn sqlite3_bind_zeroblob64(?*sqlite3_stmt, c_int, sqlite3_uint64) c_int;
pub extern fn sqlite3_bind_parameter_count(?*sqlite3_stmt) c_int;
pub extern fn sqlite3_bind_parameter_name(?*sqlite3_stmt, c_int) [*c]const u8;
pub extern fn sqlite3_bind_parameter_index(?*sqlite3_stmt, zName: [*c]const u8) c_int;
pub extern fn sqlite3_clear_bindings(?*sqlite3_stmt) c_int;
pub extern fn sqlite3_column_count(pStmt: ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_column_name(?*sqlite3_stmt, N: c_int) [*c]const u8;
pub extern fn sqlite3_column_name16(?*sqlite3_stmt, N: c_int) ?*const anyopaque;
pub extern fn sqlite3_column_database_name(?*sqlite3_stmt, c_int) [*c]const u8;
pub extern fn sqlite3_column_database_name16(?*sqlite3_stmt, c_int) ?*const anyopaque;
pub extern fn sqlite3_column_table_name(?*sqlite3_stmt, c_int) [*c]const u8;
pub extern fn sqlite3_column_table_name16(?*sqlite3_stmt, c_int) ?*const anyopaque;
pub extern fn sqlite3_column_origin_name(?*sqlite3_stmt, c_int) [*c]const u8;
pub extern fn sqlite3_column_origin_name16(?*sqlite3_stmt, c_int) ?*const anyopaque;
pub extern fn sqlite3_column_decltype(?*sqlite3_stmt, c_int) [*c]const u8;
pub extern fn sqlite3_column_decltype16(?*sqlite3_stmt, c_int) ?*const anyopaque;
pub extern fn sqlite3_step(?*sqlite3_stmt) c_int;
pub extern fn sqlite3_data_count(pStmt: ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_column_blob(?*sqlite3_stmt, iCol: c_int) ?*const anyopaque;
pub extern fn sqlite3_column_double(?*sqlite3_stmt, iCol: c_int) f64;
pub extern fn sqlite3_column_int(?*sqlite3_stmt, iCol: c_int) c_int;
pub extern fn sqlite3_column_int64(?*sqlite3_stmt, iCol: c_int) sqlite3_int64;
pub extern fn sqlite3_column_text(?*sqlite3_stmt, iCol: c_int) [*c]const u8;
pub extern fn sqlite3_column_text16(?*sqlite3_stmt, iCol: c_int) ?*const anyopaque;
pub extern fn sqlite3_column_value(?*sqlite3_stmt, iCol: c_int) ?*sqlite3_value;
pub extern fn sqlite3_column_bytes(?*sqlite3_stmt, iCol: c_int) c_int;
pub extern fn sqlite3_column_bytes16(?*sqlite3_stmt, iCol: c_int) c_int;
pub extern fn sqlite3_column_type(?*sqlite3_stmt, iCol: c_int) c_int;
pub extern fn sqlite3_finalize(pStmt: ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_reset(pStmt: ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_create_function(db: ?*sqlite3, zFunctionName: [*c]const u8, nArg: c_int, eTextRep: c_int, pApp: ?*anyopaque, xFunc: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xStep: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xFinal: ?*const fn (?*sqlite3_context) callconv(.c) void) c_int;
pub extern fn sqlite3_create_function16(db: ?*sqlite3, zFunctionName: ?*const anyopaque, nArg: c_int, eTextRep: c_int, pApp: ?*anyopaque, xFunc: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xStep: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xFinal: ?*const fn (?*sqlite3_context) callconv(.c) void) c_int;
pub extern fn sqlite3_create_function_v2(db: ?*sqlite3, zFunctionName: [*c]const u8, nArg: c_int, eTextRep: c_int, pApp: ?*anyopaque, xFunc: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xStep: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xFinal: ?*const fn (?*sqlite3_context) callconv(.c) void, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_create_window_function(db: ?*sqlite3, zFunctionName: [*c]const u8, nArg: c_int, eTextRep: c_int, pApp: ?*anyopaque, xStep: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xFinal: ?*const fn (?*sqlite3_context) callconv(.c) void, xValue: ?*const fn (?*sqlite3_context) callconv(.c) void, xInverse: ?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_aggregate_count(?*sqlite3_context) c_int;
pub extern fn sqlite3_expired(?*sqlite3_stmt) c_int;
pub extern fn sqlite3_transfer_bindings(?*sqlite3_stmt, ?*sqlite3_stmt) c_int;
pub extern fn sqlite3_global_recover() c_int;
pub extern fn sqlite3_thread_cleanup() void;
pub extern fn sqlite3_memory_alarm(?*const fn (?*anyopaque, sqlite3_int64, c_int) callconv(.c) void, ?*anyopaque, sqlite3_int64) c_int;
pub extern fn sqlite3_value_blob(?*sqlite3_value) ?*const anyopaque;
pub extern fn sqlite3_value_double(?*sqlite3_value) f64;
pub extern fn sqlite3_value_int(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_int64(?*sqlite3_value) sqlite3_int64;
pub extern fn sqlite3_value_pointer(?*sqlite3_value, [*c]const u8) ?*anyopaque;
pub extern fn sqlite3_value_text(?*sqlite3_value) [*c]const u8;
pub extern fn sqlite3_value_text16(?*sqlite3_value) ?*const anyopaque;
pub extern fn sqlite3_value_text16le(?*sqlite3_value) ?*const anyopaque;
pub extern fn sqlite3_value_text16be(?*sqlite3_value) ?*const anyopaque;
pub extern fn sqlite3_value_bytes(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_bytes16(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_type(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_numeric_type(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_nochange(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_frombind(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_encoding(?*sqlite3_value) c_int;
pub extern fn sqlite3_value_subtype(?*sqlite3_value) c_uint;
pub extern fn sqlite3_value_dup(?*const sqlite3_value) ?*sqlite3_value;
pub extern fn sqlite3_value_free(?*sqlite3_value) void;
pub extern fn sqlite3_aggregate_context(?*sqlite3_context, nBytes: c_int) ?*anyopaque;
pub extern fn sqlite3_user_data(?*sqlite3_context) ?*anyopaque;
pub extern fn sqlite3_context_db_handle(?*sqlite3_context) ?*sqlite3;
pub extern fn sqlite3_get_auxdata(?*sqlite3_context, N: c_int) ?*anyopaque;
pub extern fn sqlite3_set_auxdata(?*sqlite3_context, N: c_int, ?*anyopaque, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_get_clientdata(?*sqlite3, [*c]const u8) ?*anyopaque;
pub extern fn sqlite3_set_clientdata(?*sqlite3, [*c]const u8, ?*anyopaque, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub const sqlite3_destructor_type = ?*const fn (?*anyopaque) callconv(.c) void;
pub extern fn sqlite3_result_blob(?*sqlite3_context, ?*const anyopaque, c_int, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_blob64(?*sqlite3_context, ?*const anyopaque, sqlite3_uint64, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_double(?*sqlite3_context, f64) void;
pub extern fn sqlite3_result_error(?*sqlite3_context, [*c]const u8, c_int) void;
pub extern fn sqlite3_result_error16(?*sqlite3_context, ?*const anyopaque, c_int) void;
pub extern fn sqlite3_result_error_toobig(?*sqlite3_context) void;
pub extern fn sqlite3_result_error_nomem(?*sqlite3_context) void;
pub extern fn sqlite3_result_error_code(?*sqlite3_context, c_int) void;
pub extern fn sqlite3_result_int(?*sqlite3_context, c_int) void;
pub extern fn sqlite3_result_int64(?*sqlite3_context, sqlite3_int64) void;
pub extern fn sqlite3_result_null(?*sqlite3_context) void;
pub extern fn sqlite3_result_text(?*sqlite3_context, [*c]const u8, c_int, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_text64(?*sqlite3_context, [*c]const u8, sqlite3_uint64, ?*const fn (?*anyopaque) callconv(.c) void, encoding: u8) void;
pub extern fn sqlite3_result_text16(?*sqlite3_context, ?*const anyopaque, c_int, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_text16le(?*sqlite3_context, ?*const anyopaque, c_int, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_text16be(?*sqlite3_context, ?*const anyopaque, c_int, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_value(?*sqlite3_context, ?*sqlite3_value) void;
pub extern fn sqlite3_result_pointer(?*sqlite3_context, ?*anyopaque, [*c]const u8, ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn sqlite3_result_zeroblob(?*sqlite3_context, n: c_int) void;
pub extern fn sqlite3_result_zeroblob64(?*sqlite3_context, n: sqlite3_uint64) c_int;
pub extern fn sqlite3_result_subtype(?*sqlite3_context, c_uint) void;
pub extern fn sqlite3_create_collation(?*sqlite3, zName: [*c]const u8, eTextRep: c_int, pArg: ?*anyopaque, xCompare: ?*const fn (?*anyopaque, c_int, ?*const anyopaque, c_int, ?*const anyopaque) callconv(.c) c_int) c_int;
pub extern fn sqlite3_create_collation_v2(?*sqlite3, zName: [*c]const u8, eTextRep: c_int, pArg: ?*anyopaque, xCompare: ?*const fn (?*anyopaque, c_int, ?*const anyopaque, c_int, ?*const anyopaque) callconv(.c) c_int, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_create_collation16(?*sqlite3, zName: ?*const anyopaque, eTextRep: c_int, pArg: ?*anyopaque, xCompare: ?*const fn (?*anyopaque, c_int, ?*const anyopaque, c_int, ?*const anyopaque) callconv(.c) c_int) c_int;
pub extern fn sqlite3_collation_needed(?*sqlite3, ?*anyopaque, ?*const fn (?*anyopaque, ?*sqlite3, eTextRep: c_int, [*c]const u8) callconv(.c) void) c_int;
pub extern fn sqlite3_collation_needed16(?*sqlite3, ?*anyopaque, ?*const fn (?*anyopaque, ?*sqlite3, eTextRep: c_int, ?*const anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_sleep(c_int) c_int;
pub extern var sqlite3_temp_directory: [*c]u8;
pub extern var sqlite3_data_directory: [*c]u8;
pub extern fn sqlite3_win32_set_directory(@"type": c_ulong, zValue: ?*anyopaque) c_int;
pub extern fn sqlite3_win32_set_directory8(@"type": c_ulong, zValue: [*c]const u8) c_int;
pub extern fn sqlite3_win32_set_directory16(@"type": c_ulong, zValue: ?*const anyopaque) c_int;
pub extern fn sqlite3_get_autocommit(?*sqlite3) c_int;
pub extern fn sqlite3_db_handle(?*sqlite3_stmt) ?*sqlite3;
pub extern fn sqlite3_db_name(db: ?*sqlite3, N: c_int) [*c]const u8;
pub extern fn sqlite3_db_filename(db: ?*sqlite3, zDbName: [*c]const u8) sqlite3_filename;
pub extern fn sqlite3_db_readonly(db: ?*sqlite3, zDbName: [*c]const u8) c_int;
pub extern fn sqlite3_txn_state(?*sqlite3, zSchema: [*c]const u8) c_int;
pub extern fn sqlite3_next_stmt(pDb: ?*sqlite3, pStmt: ?*sqlite3_stmt) ?*sqlite3_stmt;
pub extern fn sqlite3_commit_hook(?*sqlite3, ?*const fn (?*anyopaque) callconv(.c) c_int, ?*anyopaque) ?*anyopaque;
pub extern fn sqlite3_rollback_hook(?*sqlite3, ?*const fn (?*anyopaque) callconv(.c) void, ?*anyopaque) ?*anyopaque;
pub extern fn sqlite3_autovacuum_pages(db: ?*sqlite3, ?*const fn (?*anyopaque, [*c]const u8, c_uint, c_uint, c_uint) callconv(.c) c_uint, ?*anyopaque, ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_update_hook(?*sqlite3, ?*const fn (?*anyopaque, c_int, [*c]const u8, [*c]const u8, sqlite3_int64) callconv(.c) void, ?*anyopaque) ?*anyopaque;
pub extern fn sqlite3_enable_shared_cache(c_int) c_int;
pub extern fn sqlite3_release_memory(c_int) c_int;
pub extern fn sqlite3_db_release_memory(?*sqlite3) c_int;
pub extern fn sqlite3_soft_heap_limit64(N: sqlite3_int64) sqlite3_int64;
pub extern fn sqlite3_hard_heap_limit64(N: sqlite3_int64) sqlite3_int64;
pub extern fn sqlite3_soft_heap_limit(N: c_int) void;
pub extern fn sqlite3_table_column_metadata(db: ?*sqlite3, zDbName: [*c]const u8, zTableName: [*c]const u8, zColumnName: [*c]const u8, pzDataType: [*c][*c]const u8, pzCollSeq: [*c][*c]const u8, pNotNull: [*c]c_int, pPrimaryKey: [*c]c_int, pAutoinc: [*c]c_int) c_int;
pub extern fn sqlite3_load_extension(db: ?*sqlite3, zFile: [*c]const u8, zProc: [*c]const u8, pzErrMsg: [*c][*c]u8) c_int;
pub extern fn sqlite3_enable_load_extension(db: ?*sqlite3, onoff: c_int) c_int;
pub extern fn sqlite3_auto_extension(xEntryPoint: ?*const fn () callconv(.c) void) c_int;
pub extern fn sqlite3_cancel_auto_extension(xEntryPoint: ?*const fn () callconv(.c) void) c_int;
pub extern fn sqlite3_reset_auto_extension() void;
pub const struct_sqlite3_index_constraint_2 = extern struct {
    iColumn: c_int = 0,
    op: u8 = 0,
    usable: u8 = 0,
    iTermOffset: c_int = 0,
};
pub const struct_sqlite3_index_orderby_3 = extern struct {
    iColumn: c_int = 0,
    desc: u8 = 0,
};
pub const struct_sqlite3_index_constraint_usage_4 = extern struct {
    argvIndex: c_int = 0,
    omit: u8 = 0,
};
pub const struct_sqlite3_index_info = extern struct {
    nConstraint: c_int = 0,
    aConstraint: [*c]struct_sqlite3_index_constraint_2 = null,
    nOrderBy: c_int = 0,
    aOrderBy: [*c]struct_sqlite3_index_orderby_3 = null,
    aConstraintUsage: [*c]struct_sqlite3_index_constraint_usage_4 = null,
    idxNum: c_int = 0,
    idxStr: [*c]u8 = null,
    needToFreeIdxStr: c_int = 0,
    orderByConsumed: c_int = 0,
    estimatedCost: f64 = 0,
    estimatedRows: sqlite3_int64 = 0,
    idxFlags: c_int = 0,
    colUsed: sqlite3_uint64 = 0,
    pub const collation = sqlite3_vtab_collation;
    pub const distinct = sqlite3_vtab_distinct;
    pub const in = sqlite3_vtab_in;
    pub const value = sqlite3_vtab_rhs_value;
};
pub const sqlite3_index_info = struct_sqlite3_index_info;
pub const struct_sqlite3_vtab_cursor = extern struct {
    pVtab: [*c]sqlite3_vtab = null,
};
pub const sqlite3_vtab_cursor = struct_sqlite3_vtab_cursor;
pub const struct_sqlite3_module = extern struct {
    iVersion: c_int = 0,
    xCreate: ?*const fn (?*sqlite3, pAux: ?*anyopaque, argc: c_int, argv: [*c]const [*c]const u8, ppVTab: [*c][*c]sqlite3_vtab, [*c][*c]u8) callconv(.c) c_int = null,
    xConnect: ?*const fn (?*sqlite3, pAux: ?*anyopaque, argc: c_int, argv: [*c]const [*c]const u8, ppVTab: [*c][*c]sqlite3_vtab, [*c][*c]u8) callconv(.c) c_int = null,
    xBestIndex: ?*const fn (pVTab: [*c]sqlite3_vtab, [*c]sqlite3_index_info) callconv(.c) c_int = null,
    xDisconnect: ?*const fn (pVTab: [*c]sqlite3_vtab) callconv(.c) c_int = null,
    xDestroy: ?*const fn (pVTab: [*c]sqlite3_vtab) callconv(.c) c_int = null,
    xOpen: ?*const fn (pVTab: [*c]sqlite3_vtab, ppCursor: [*c][*c]sqlite3_vtab_cursor) callconv(.c) c_int = null,
    xClose: ?*const fn ([*c]sqlite3_vtab_cursor) callconv(.c) c_int = null,
    xFilter: ?*const fn ([*c]sqlite3_vtab_cursor, idxNum: c_int, idxStr: [*c]const u8, argc: c_int, argv: [*c]?*sqlite3_value) callconv(.c) c_int = null,
    xNext: ?*const fn ([*c]sqlite3_vtab_cursor) callconv(.c) c_int = null,
    xEof: ?*const fn ([*c]sqlite3_vtab_cursor) callconv(.c) c_int = null,
    xColumn: ?*const fn ([*c]sqlite3_vtab_cursor, ?*sqlite3_context, c_int) callconv(.c) c_int = null,
    xRowid: ?*const fn ([*c]sqlite3_vtab_cursor, pRowid: [*c]sqlite3_int64) callconv(.c) c_int = null,
    xUpdate: ?*const fn ([*c]sqlite3_vtab, c_int, [*c]?*sqlite3_value, [*c]sqlite3_int64) callconv(.c) c_int = null,
    xBegin: ?*const fn (pVTab: [*c]sqlite3_vtab) callconv(.c) c_int = null,
    xSync: ?*const fn (pVTab: [*c]sqlite3_vtab) callconv(.c) c_int = null,
    xCommit: ?*const fn (pVTab: [*c]sqlite3_vtab) callconv(.c) c_int = null,
    xRollback: ?*const fn (pVTab: [*c]sqlite3_vtab) callconv(.c) c_int = null,
    xFindFunction: ?*const fn (pVtab: [*c]sqlite3_vtab, nArg: c_int, zName: [*c]const u8, pxFunc: [*c]?*const fn (?*sqlite3_context, c_int, [*c]?*sqlite3_value) callconv(.c) void, ppArg: [*c]?*anyopaque) callconv(.c) c_int = null,
    xRename: ?*const fn (pVtab: [*c]sqlite3_vtab, zNew: [*c]const u8) callconv(.c) c_int = null,
    xSavepoint: ?*const fn (pVTab: [*c]sqlite3_vtab, c_int) callconv(.c) c_int = null,
    xRelease: ?*const fn (pVTab: [*c]sqlite3_vtab, c_int) callconv(.c) c_int = null,
    xRollbackTo: ?*const fn (pVTab: [*c]sqlite3_vtab, c_int) callconv(.c) c_int = null,
    xShadowName: ?*const fn ([*c]const u8) callconv(.c) c_int = null,
    xIntegrity: ?*const fn (pVTab: [*c]sqlite3_vtab, zSchema: [*c]const u8, zTabName: [*c]const u8, mFlags: c_int, pzErr: [*c][*c]u8) callconv(.c) c_int = null,
};
pub const sqlite3_module = struct_sqlite3_module;
pub const struct_sqlite3_vtab = extern struct {
    pModule: [*c]const sqlite3_module = null,
    nRef: c_int = 0,
    zErrMsg: [*c]u8 = null,
};
pub const sqlite3_vtab = struct_sqlite3_vtab;
pub extern fn sqlite3_create_module(db: ?*sqlite3, zName: [*c]const u8, p: [*c]const sqlite3_module, pClientData: ?*anyopaque) c_int;
pub extern fn sqlite3_create_module_v2(db: ?*sqlite3, zName: [*c]const u8, p: [*c]const sqlite3_module, pClientData: ?*anyopaque, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn sqlite3_drop_modules(db: ?*sqlite3, azKeep: [*c][*c]const u8) c_int;
pub extern fn sqlite3_declare_vtab(?*sqlite3, zSQL: [*c]const u8) c_int;
pub extern fn sqlite3_overload_function(?*sqlite3, zFuncName: [*c]const u8, nArg: c_int) c_int;
pub const struct_sqlite3_blob = opaque {
    pub const reopen = sqlite3_blob_reopen;
    pub const close = sqlite3_blob_close;
    pub const bytes = sqlite3_blob_bytes;
    pub const read = sqlite3_blob_read;
    pub const write = sqlite3_blob_write;
};
pub const sqlite3_blob = struct_sqlite3_blob;
pub extern fn sqlite3_blob_open(?*sqlite3, zDb: [*c]const u8, zTable: [*c]const u8, zColumn: [*c]const u8, iRow: sqlite3_int64, flags: c_int, ppBlob: [*c]?*sqlite3_blob) c_int;
pub extern fn sqlite3_blob_reopen(?*sqlite3_blob, sqlite3_int64) c_int;
pub extern fn sqlite3_blob_close(?*sqlite3_blob) c_int;
pub extern fn sqlite3_blob_bytes(?*sqlite3_blob) c_int;
pub extern fn sqlite3_blob_read(?*sqlite3_blob, Z: ?*anyopaque, N: c_int, iOffset: c_int) c_int;
pub extern fn sqlite3_blob_write(?*sqlite3_blob, z: ?*const anyopaque, n: c_int, iOffset: c_int) c_int;
pub extern fn sqlite3_vfs_find(zVfsName: [*c]const u8) [*c]sqlite3_vfs;
pub extern fn sqlite3_vfs_register([*c]sqlite3_vfs, makeDflt: c_int) c_int;
pub extern fn sqlite3_vfs_unregister([*c]sqlite3_vfs) c_int;
pub extern fn sqlite3_mutex_alloc(c_int) ?*sqlite3_mutex;
pub extern fn sqlite3_mutex_free(?*sqlite3_mutex) void;
pub extern fn sqlite3_mutex_enter(?*sqlite3_mutex) void;
pub extern fn sqlite3_mutex_try(?*sqlite3_mutex) c_int;
pub extern fn sqlite3_mutex_leave(?*sqlite3_mutex) void;
pub const struct_sqlite3_mutex_methods = extern struct {
    xMutexInit: ?*const fn () callconv(.c) c_int = null,
    xMutexEnd: ?*const fn () callconv(.c) c_int = null,
    xMutexAlloc: ?*const fn (c_int) callconv(.c) ?*sqlite3_mutex = null,
    xMutexFree: ?*const fn (?*sqlite3_mutex) callconv(.c) void = null,
    xMutexEnter: ?*const fn (?*sqlite3_mutex) callconv(.c) void = null,
    xMutexTry: ?*const fn (?*sqlite3_mutex) callconv(.c) c_int = null,
    xMutexLeave: ?*const fn (?*sqlite3_mutex) callconv(.c) void = null,
    xMutexHeld: ?*const fn (?*sqlite3_mutex) callconv(.c) c_int = null,
    xMutexNotheld: ?*const fn (?*sqlite3_mutex) callconv(.c) c_int = null,
};
pub const sqlite3_mutex_methods = struct_sqlite3_mutex_methods;
pub extern fn sqlite3_mutex_held(?*sqlite3_mutex) c_int;
pub extern fn sqlite3_mutex_notheld(?*sqlite3_mutex) c_int;
pub extern fn sqlite3_db_mutex(?*sqlite3) ?*sqlite3_mutex;
pub extern fn sqlite3_file_control(?*sqlite3, zDbName: [*c]const u8, op: c_int, ?*anyopaque) c_int;
pub extern fn sqlite3_test_control(op: c_int, ...) c_int;
pub extern fn sqlite3_keyword_count() c_int;
pub extern fn sqlite3_keyword_name(c_int, [*c][*c]const u8, [*c]c_int) c_int;
pub extern fn sqlite3_keyword_check([*c]const u8, c_int) c_int;
pub const struct_sqlite3_str = opaque {
    pub const finish = sqlite3_str_finish;
    pub const appendf = sqlite3_str_appendf;
    pub const vappendf = sqlite3_str_vappendf;
    pub const append = sqlite3_str_append;
    pub const appendall = sqlite3_str_appendall;
    pub const appendchar = sqlite3_str_appendchar;
    pub const reset = sqlite3_str_reset;
    pub const errcode = sqlite3_str_errcode;
    pub const length = sqlite3_str_length;
    pub const value = sqlite3_str_value;
};
pub const sqlite3_str = struct_sqlite3_str;
pub extern fn sqlite3_str_new(?*sqlite3) ?*sqlite3_str;
pub extern fn sqlite3_str_finish(?*sqlite3_str) [*c]u8;
pub extern fn sqlite3_str_appendf(?*sqlite3_str, zFormat: [*c]const u8, ...) void;
pub extern fn sqlite3_str_vappendf(?*sqlite3_str, zFormat: [*c]const u8, [*c]struct___va_list_tag_1) void;
pub extern fn sqlite3_str_append(?*sqlite3_str, zIn: [*c]const u8, N: c_int) void;
pub extern fn sqlite3_str_appendall(?*sqlite3_str, zIn: [*c]const u8) void;
pub extern fn sqlite3_str_appendchar(?*sqlite3_str, N: c_int, C: u8) void;
pub extern fn sqlite3_str_reset(?*sqlite3_str) void;
pub extern fn sqlite3_str_errcode(?*sqlite3_str) c_int;
pub extern fn sqlite3_str_length(?*sqlite3_str) c_int;
pub extern fn sqlite3_str_value(?*sqlite3_str) [*c]u8;
pub extern fn sqlite3_status(op: c_int, pCurrent: [*c]c_int, pHighwater: [*c]c_int, resetFlag: c_int) c_int;
pub extern fn sqlite3_status64(op: c_int, pCurrent: [*c]sqlite3_int64, pHighwater: [*c]sqlite3_int64, resetFlag: c_int) c_int;
pub extern fn sqlite3_db_status(?*sqlite3, op: c_int, pCur: [*c]c_int, pHiwtr: [*c]c_int, resetFlg: c_int) c_int;
pub extern fn sqlite3_stmt_status(?*sqlite3_stmt, op: c_int, resetFlg: c_int) c_int;
pub const struct_sqlite3_pcache = opaque {};
pub const sqlite3_pcache = struct_sqlite3_pcache;
pub const struct_sqlite3_pcache_page = extern struct {
    pBuf: ?*anyopaque = null,
    pExtra: ?*anyopaque = null,
};
pub const sqlite3_pcache_page = struct_sqlite3_pcache_page;
pub const struct_sqlite3_pcache_methods2 = extern struct {
    iVersion: c_int = 0,
    pArg: ?*anyopaque = null,
    xInit: ?*const fn (?*anyopaque) callconv(.c) c_int = null,
    xShutdown: ?*const fn (?*anyopaque) callconv(.c) void = null,
    xCreate: ?*const fn (szPage: c_int, szExtra: c_int, bPurgeable: c_int) callconv(.c) ?*sqlite3_pcache = null,
    xCachesize: ?*const fn (?*sqlite3_pcache, nCachesize: c_int) callconv(.c) void = null,
    xPagecount: ?*const fn (?*sqlite3_pcache) callconv(.c) c_int = null,
    xFetch: ?*const fn (?*sqlite3_pcache, key: c_uint, createFlag: c_int) callconv(.c) [*c]sqlite3_pcache_page = null,
    xUnpin: ?*const fn (?*sqlite3_pcache, [*c]sqlite3_pcache_page, discard: c_int) callconv(.c) void = null,
    xRekey: ?*const fn (?*sqlite3_pcache, [*c]sqlite3_pcache_page, oldKey: c_uint, newKey: c_uint) callconv(.c) void = null,
    xTruncate: ?*const fn (?*sqlite3_pcache, iLimit: c_uint) callconv(.c) void = null,
    xDestroy: ?*const fn (?*sqlite3_pcache) callconv(.c) void = null,
    xShrink: ?*const fn (?*sqlite3_pcache) callconv(.c) void = null,
};
pub const sqlite3_pcache_methods2 = struct_sqlite3_pcache_methods2;
pub const struct_sqlite3_pcache_methods = extern struct {
    pArg: ?*anyopaque = null,
    xInit: ?*const fn (?*anyopaque) callconv(.c) c_int = null,
    xShutdown: ?*const fn (?*anyopaque) callconv(.c) void = null,
    xCreate: ?*const fn (szPage: c_int, bPurgeable: c_int) callconv(.c) ?*sqlite3_pcache = null,
    xCachesize: ?*const fn (?*sqlite3_pcache, nCachesize: c_int) callconv(.c) void = null,
    xPagecount: ?*const fn (?*sqlite3_pcache) callconv(.c) c_int = null,
    xFetch: ?*const fn (?*sqlite3_pcache, key: c_uint, createFlag: c_int) callconv(.c) ?*anyopaque = null,
    xUnpin: ?*const fn (?*sqlite3_pcache, ?*anyopaque, discard: c_int) callconv(.c) void = null,
    xRekey: ?*const fn (?*sqlite3_pcache, ?*anyopaque, oldKey: c_uint, newKey: c_uint) callconv(.c) void = null,
    xTruncate: ?*const fn (?*sqlite3_pcache, iLimit: c_uint) callconv(.c) void = null,
    xDestroy: ?*const fn (?*sqlite3_pcache) callconv(.c) void = null,
};
pub const sqlite3_pcache_methods = struct_sqlite3_pcache_methods;
pub const struct_sqlite3_backup = opaque {
    pub const step = sqlite3_backup_step;
    pub const finish = sqlite3_backup_finish;
    pub const remaining = sqlite3_backup_remaining;
    pub const pagecount = sqlite3_backup_pagecount;
};
pub const sqlite3_backup = struct_sqlite3_backup;
pub extern fn sqlite3_backup_init(pDest: ?*sqlite3, zDestName: [*c]const u8, pSource: ?*sqlite3, zSourceName: [*c]const u8) ?*sqlite3_backup;
pub extern fn sqlite3_backup_step(p: ?*sqlite3_backup, nPage: c_int) c_int;
pub extern fn sqlite3_backup_finish(p: ?*sqlite3_backup) c_int;
pub extern fn sqlite3_backup_remaining(p: ?*sqlite3_backup) c_int;
pub extern fn sqlite3_backup_pagecount(p: ?*sqlite3_backup) c_int;
pub extern fn sqlite3_unlock_notify(pBlocked: ?*sqlite3, xNotify: ?*const fn (apArg: [*c]?*anyopaque, nArg: c_int) callconv(.c) void, pNotifyArg: ?*anyopaque) c_int;
pub extern fn sqlite3_stricmp([*c]const u8, [*c]const u8) c_int;
pub extern fn sqlite3_strnicmp([*c]const u8, [*c]const u8, c_int) c_int;
pub extern fn sqlite3_strglob(zGlob: [*c]const u8, zStr: [*c]const u8) c_int;
pub extern fn sqlite3_strlike(zGlob: [*c]const u8, zStr: [*c]const u8, cEsc: c_uint) c_int;
pub extern fn sqlite3_log(iErrCode: c_int, zFormat: [*c]const u8, ...) void;
pub extern fn sqlite3_wal_hook(?*sqlite3, ?*const fn (?*anyopaque, ?*sqlite3, [*c]const u8, c_int) callconv(.c) c_int, ?*anyopaque) ?*anyopaque;
pub extern fn sqlite3_wal_autocheckpoint(db: ?*sqlite3, N: c_int) c_int;
pub extern fn sqlite3_wal_checkpoint(db: ?*sqlite3, zDb: [*c]const u8) c_int;
pub extern fn sqlite3_wal_checkpoint_v2(db: ?*sqlite3, zDb: [*c]const u8, eMode: c_int, pnLog: [*c]c_int, pnCkpt: [*c]c_int) c_int;
pub extern fn sqlite3_vtab_config(?*sqlite3, op: c_int, ...) c_int;
pub extern fn sqlite3_vtab_on_conflict(?*sqlite3) c_int;
pub extern fn sqlite3_vtab_nochange(?*sqlite3_context) c_int;
pub extern fn sqlite3_vtab_collation([*c]sqlite3_index_info, c_int) [*c]const u8;
pub extern fn sqlite3_vtab_distinct([*c]sqlite3_index_info) c_int;
pub extern fn sqlite3_vtab_in([*c]sqlite3_index_info, iCons: c_int, bHandle: c_int) c_int;
pub extern fn sqlite3_vtab_in_first(pVal: ?*sqlite3_value, ppOut: [*c]?*sqlite3_value) c_int;
pub extern fn sqlite3_vtab_in_next(pVal: ?*sqlite3_value, ppOut: [*c]?*sqlite3_value) c_int;
pub extern fn sqlite3_vtab_rhs_value([*c]sqlite3_index_info, c_int, ppVal: [*c]?*sqlite3_value) c_int;
pub extern fn sqlite3_stmt_scanstatus(pStmt: ?*sqlite3_stmt, idx: c_int, iScanStatusOp: c_int, pOut: ?*anyopaque) c_int;
pub extern fn sqlite3_stmt_scanstatus_v2(pStmt: ?*sqlite3_stmt, idx: c_int, iScanStatusOp: c_int, flags: c_int, pOut: ?*anyopaque) c_int;
pub extern fn sqlite3_stmt_scanstatus_reset(?*sqlite3_stmt) void;
pub extern fn sqlite3_db_cacheflush(?*sqlite3) c_int;
pub extern fn sqlite3_system_errno(?*sqlite3) c_int;
pub const struct_sqlite3_snapshot = extern struct {
    hidden: [48]u8 = @import("std").mem.zeroes([48]u8),
    pub const free = sqlite3_snapshot_free;
    pub const cmp = sqlite3_snapshot_cmp;
};
pub const sqlite3_snapshot = struct_sqlite3_snapshot;
pub extern fn sqlite3_snapshot_get(db: ?*sqlite3, zSchema: [*c]const u8, ppSnapshot: [*c][*c]sqlite3_snapshot) c_int;
pub extern fn sqlite3_snapshot_open(db: ?*sqlite3, zSchema: [*c]const u8, pSnapshot: [*c]sqlite3_snapshot) c_int;
pub extern fn sqlite3_snapshot_free([*c]sqlite3_snapshot) void;
pub extern fn sqlite3_snapshot_cmp(p1: [*c]sqlite3_snapshot, p2: [*c]sqlite3_snapshot) c_int;
pub extern fn sqlite3_snapshot_recover(db: ?*sqlite3, zDb: [*c]const u8) c_int;
pub extern fn sqlite3_serialize(db: ?*sqlite3, zSchema: [*c]const u8, piSize: [*c]sqlite3_int64, mFlags: c_uint) [*c]u8;
pub extern fn sqlite3_deserialize(db: ?*sqlite3, zSchema: [*c]const u8, pData: [*c]u8, szDb: sqlite3_int64, szBuf: sqlite3_int64, mFlags: c_uint) c_int;
pub const sqlite3_rtree_dbl = f64;
pub const struct_sqlite3_rtree_geometry = extern struct {
    pContext: ?*anyopaque = null,
    nParam: c_int = 0,
    aParam: [*c]sqlite3_rtree_dbl = null,
    pUser: ?*anyopaque = null,
    xDelUser: ?*const fn (?*anyopaque) callconv(.c) void = null,
};
pub const sqlite3_rtree_geometry = struct_sqlite3_rtree_geometry;
pub const struct_sqlite3_rtree_query_info = extern struct {
    pContext: ?*anyopaque = null,
    nParam: c_int = 0,
    aParam: [*c]sqlite3_rtree_dbl = null,
    pUser: ?*anyopaque = null,
    xDelUser: ?*const fn (?*anyopaque) callconv(.c) void = null,
    aCoord: [*c]sqlite3_rtree_dbl = null,
    anQueue: [*c]c_uint = null,
    nCoord: c_int = 0,
    iLevel: c_int = 0,
    mxLevel: c_int = 0,
    iRowid: sqlite3_int64 = 0,
    rParentScore: sqlite3_rtree_dbl = 0,
    eParentWithin: c_int = 0,
    eWithin: c_int = 0,
    rScore: sqlite3_rtree_dbl = 0,
    apSqlParam: [*c]?*sqlite3_value = null,
};
pub const sqlite3_rtree_query_info = struct_sqlite3_rtree_query_info;
pub extern fn sqlite3_rtree_geometry_callback(db: ?*sqlite3, zGeom: [*c]const u8, xGeom: ?*const fn ([*c]sqlite3_rtree_geometry, c_int, [*c]sqlite3_rtree_dbl, [*c]c_int) callconv(.c) c_int, pContext: ?*anyopaque) c_int;
pub extern fn sqlite3_rtree_query_callback(db: ?*sqlite3, zQueryFunc: [*c]const u8, xQueryFunc: ?*const fn ([*c]sqlite3_rtree_query_info) callconv(.c) c_int, pContext: ?*anyopaque, xDestructor: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub const struct_Fts5Context = opaque {};
pub const Fts5Context = struct_Fts5Context;
pub const struct_Fts5PhraseIter = extern struct {
    a: [*c]const u8 = null,
    b: [*c]const u8 = null,
};
pub const Fts5PhraseIter = struct_Fts5PhraseIter;
pub const struct_Fts5ExtensionApi = extern struct {
    iVersion: c_int = 0,
    xUserData: ?*const fn (?*Fts5Context) callconv(.c) ?*anyopaque = null,
    xColumnCount: ?*const fn (?*Fts5Context) callconv(.c) c_int = null,
    xRowCount: ?*const fn (?*Fts5Context, pnRow: [*c]sqlite3_int64) callconv(.c) c_int = null,
    xColumnTotalSize: ?*const fn (?*Fts5Context, iCol: c_int, pnToken: [*c]sqlite3_int64) callconv(.c) c_int = null,
    xTokenize: ?*const fn (?*Fts5Context, pText: [*c]const u8, nText: c_int, pCtx: ?*anyopaque, xToken: ?*const fn (?*anyopaque, c_int, [*c]const u8, c_int, c_int, c_int) callconv(.c) c_int) callconv(.c) c_int = null,
    xPhraseCount: ?*const fn (?*Fts5Context) callconv(.c) c_int = null,
    xPhraseSize: ?*const fn (?*Fts5Context, iPhrase: c_int) callconv(.c) c_int = null,
    xInstCount: ?*const fn (?*Fts5Context, pnInst: [*c]c_int) callconv(.c) c_int = null,
    xInst: ?*const fn (?*Fts5Context, iIdx: c_int, piPhrase: [*c]c_int, piCol: [*c]c_int, piOff: [*c]c_int) callconv(.c) c_int = null,
    xRowid: ?*const fn (?*Fts5Context) callconv(.c) sqlite3_int64 = null,
    xColumnText: ?*const fn (?*Fts5Context, iCol: c_int, pz: [*c][*c]const u8, pn: [*c]c_int) callconv(.c) c_int = null,
    xColumnSize: ?*const fn (?*Fts5Context, iCol: c_int, pnToken: [*c]c_int) callconv(.c) c_int = null,
    xQueryPhrase: ?*const fn (?*Fts5Context, iPhrase: c_int, pUserData: ?*anyopaque, ?*const fn ([*c]const Fts5ExtensionApi, ?*Fts5Context, ?*anyopaque) callconv(.c) c_int) callconv(.c) c_int = null,
    xSetAuxdata: ?*const fn (?*Fts5Context, pAux: ?*anyopaque, xDelete: ?*const fn (?*anyopaque) callconv(.c) void) callconv(.c) c_int = null,
    xGetAuxdata: ?*const fn (?*Fts5Context, bClear: c_int) callconv(.c) ?*anyopaque = null,
    xPhraseFirst: ?*const fn (?*Fts5Context, iPhrase: c_int, [*c]Fts5PhraseIter, [*c]c_int, [*c]c_int) callconv(.c) c_int = null,
    xPhraseNext: ?*const fn (?*Fts5Context, [*c]Fts5PhraseIter, piCol: [*c]c_int, piOff: [*c]c_int) callconv(.c) void = null,
    xPhraseFirstColumn: ?*const fn (?*Fts5Context, iPhrase: c_int, [*c]Fts5PhraseIter, [*c]c_int) callconv(.c) c_int = null,
    xPhraseNextColumn: ?*const fn (?*Fts5Context, [*c]Fts5PhraseIter, piCol: [*c]c_int) callconv(.c) void = null,
    xQueryToken: ?*const fn (?*Fts5Context, iPhrase: c_int, iToken: c_int, ppToken: [*c][*c]const u8, pnToken: [*c]c_int) callconv(.c) c_int = null,
    xInstToken: ?*const fn (?*Fts5Context, iIdx: c_int, iToken: c_int, [*c][*c]const u8, [*c]c_int) callconv(.c) c_int = null,
    xColumnLocale: ?*const fn (?*Fts5Context, iCol: c_int, pz: [*c][*c]const u8, pn: [*c]c_int) callconv(.c) c_int = null,
    xTokenize_v2: ?*const fn (?*Fts5Context, pText: [*c]const u8, nText: c_int, pLocale: [*c]const u8, nLocale: c_int, pCtx: ?*anyopaque, xToken: ?*const fn (?*anyopaque, c_int, [*c]const u8, c_int, c_int, c_int) callconv(.c) c_int) callconv(.c) c_int = null,
};
pub const Fts5ExtensionApi = struct_Fts5ExtensionApi;
pub const fts5_extension_function = ?*const fn (pApi: [*c]const Fts5ExtensionApi, pFts: ?*Fts5Context, pCtx: ?*sqlite3_context, nVal: c_int, apVal: [*c]?*sqlite3_value) callconv(.c) void;
pub const struct_Fts5Tokenizer = opaque {};
pub const Fts5Tokenizer = struct_Fts5Tokenizer;
pub const struct_fts5_tokenizer_v2 = extern struct {
    iVersion: c_int = 0,
    xCreate: ?*const fn (?*anyopaque, azArg: [*c][*c]const u8, nArg: c_int, ppOut: [*c]?*Fts5Tokenizer) callconv(.c) c_int = null,
    xDelete: ?*const fn (?*Fts5Tokenizer) callconv(.c) void = null,
    xTokenize: ?*const fn (?*Fts5Tokenizer, pCtx: ?*anyopaque, flags: c_int, pText: [*c]const u8, nText: c_int, pLocale: [*c]const u8, nLocale: c_int, xToken: ?*const fn (pCtx: ?*anyopaque, tflags: c_int, pToken: [*c]const u8, nToken: c_int, iStart: c_int, iEnd: c_int) callconv(.c) c_int) callconv(.c) c_int = null,
};
pub const fts5_tokenizer_v2 = struct_fts5_tokenizer_v2;
pub const struct_fts5_tokenizer = extern struct {
    xCreate: ?*const fn (?*anyopaque, azArg: [*c][*c]const u8, nArg: c_int, ppOut: [*c]?*Fts5Tokenizer) callconv(.c) c_int = null,
    xDelete: ?*const fn (?*Fts5Tokenizer) callconv(.c) void = null,
    xTokenize: ?*const fn (?*Fts5Tokenizer, pCtx: ?*anyopaque, flags: c_int, pText: [*c]const u8, nText: c_int, xToken: ?*const fn (pCtx: ?*anyopaque, tflags: c_int, pToken: [*c]const u8, nToken: c_int, iStart: c_int, iEnd: c_int) callconv(.c) c_int) callconv(.c) c_int = null,
};
pub const fts5_tokenizer = struct_fts5_tokenizer;
pub const struct_fts5_api = extern struct {
    iVersion: c_int = 0,
    xCreateTokenizer: ?*const fn (pApi: [*c]fts5_api, zName: [*c]const u8, pUserData: ?*anyopaque, pTokenizer: [*c]fts5_tokenizer, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) callconv(.c) c_int = null,
    xFindTokenizer: ?*const fn (pApi: [*c]fts5_api, zName: [*c]const u8, ppUserData: [*c]?*anyopaque, pTokenizer: [*c]fts5_tokenizer) callconv(.c) c_int = null,
    xCreateFunction: ?*const fn (pApi: [*c]fts5_api, zName: [*c]const u8, pUserData: ?*anyopaque, xFunction: fts5_extension_function, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) callconv(.c) c_int = null,
    xCreateTokenizer_v2: ?*const fn (pApi: [*c]fts5_api, zName: [*c]const u8, pUserData: ?*anyopaque, pTokenizer: [*c]fts5_tokenizer_v2, xDestroy: ?*const fn (?*anyopaque) callconv(.c) void) callconv(.c) c_int = null,
    xFindTokenizer_v2: ?*const fn (pApi: [*c]fts5_api, zName: [*c]const u8, ppUserData: [*c]?*anyopaque, ppTokenizer: [*c][*c]fts5_tokenizer_v2) callconv(.c) c_int = null,
};
pub const fts5_api = struct_fts5_api;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const IN_CLOEXEC: c_int = 524288;
pub const IN_NONBLOCK: c_int = 2048;
const enum_unnamed_5 = c_uint;
pub const struct_inotify_event = extern struct {
    wd: c_int = 0,
    mask: u32 = 0,
    cookie: u32 = 0,
    len: u32 = 0,
    _name: [0]u8 = @import("std").mem.zeroes([0]u8),
    pub fn name(self: anytype) __helpers.FlexibleArrayType(@TypeOf(self), @typeInfo(@TypeOf(self.*._name)).array.child) {
        return @ptrCast(&self.*._name);
    }
};
pub extern fn inotify_init() c_int;
pub extern fn inotify_init1(__flags: c_int) c_int;
pub extern fn inotify_add_watch(__fd: c_int, __name: [*c]const u8, __mask: u32) c_int;
pub extern fn inotify_rm_watch(__fd: c_int, __wd: c_int) c_int;
pub const dbus_int64_t = c_long;
pub const dbus_uint64_t = c_ulong;
pub const dbus_int32_t = c_int;
pub const dbus_uint32_t = c_uint;
pub const dbus_int16_t = c_short;
pub const dbus_uint16_t = c_ushort;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __aro_max_align_ll: c_longlong = 0,
    __aro_max_align_ld: c_longdouble = 0,
};
pub const dbus_unichar_t = dbus_uint32_t;
pub const dbus_bool_t = dbus_uint32_t;
pub const DBus8ByteStruct = extern struct {
    first32: dbus_uint32_t = 0,
    second32: dbus_uint32_t = 0,
};
pub const DBusBasicValue = extern union {
    bytes: [8]u8,
    i16: dbus_int16_t,
    u16: dbus_uint16_t,
    i32: dbus_int32_t,
    u32: dbus_uint32_t,
    bool_val: dbus_bool_t,
    i64: dbus_int64_t,
    u64: dbus_uint64_t,
    eight: DBus8ByteStruct,
    dbl: f64,
    byt: u8,
    str: [*c]u8,
    fd: c_int,
}; // /usr/include/dbus-1.0/dbus/dbus-errors.h:55:16: warning: struct demoted to opaque type - has bitfield
pub const struct_DBusError = opaque {
    pub const init = dbus_error_init;
    pub const free = dbus_error_free;
    pub const @"error" = dbus_set_error;
    pub const @"const" = dbus_set_error_const;
    pub const error1 = dbus_move_error;
    pub const name = dbus_error_has_name;
    pub const set = dbus_error_is_set;
    pub const message = dbus_set_error_from_message;
    pub const id = dbus_try_get_local_machine_id;
};
pub const DBusError = struct_DBusError;
pub extern fn dbus_error_init(@"error": ?*DBusError) void;
pub extern fn dbus_error_free(@"error": ?*DBusError) void;
pub extern fn dbus_set_error(@"error": ?*DBusError, name: [*c]const u8, message: [*c]const u8, ...) void;
pub extern fn dbus_set_error_const(@"error": ?*DBusError, name: [*c]const u8, message: [*c]const u8) void;
pub extern fn dbus_move_error(src: ?*DBusError, dest: ?*DBusError) void;
pub extern fn dbus_error_has_name(@"error": ?*const DBusError, name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_error_is_set(@"error": ?*const DBusError) dbus_bool_t;
pub const struct_DBusAddressEntry = opaque {
    pub const value = dbus_address_entry_get_value;
    pub const method = dbus_address_entry_get_method;
};
pub const DBusAddressEntry = struct_DBusAddressEntry;
pub extern fn dbus_parse_address(address: [*c]const u8, entry_result: [*c][*c]?*DBusAddressEntry, array_len: [*c]c_int, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_address_entry_get_value(entry: ?*DBusAddressEntry, key: [*c]const u8) [*c]const u8;
pub extern fn dbus_address_entry_get_method(entry: ?*DBusAddressEntry) [*c]const u8;
pub extern fn dbus_address_entries_free(entries: [*c]?*DBusAddressEntry) void;
pub extern fn dbus_address_escape_value(value: [*c]const u8) [*c]u8;
pub extern fn dbus_address_unescape_value(value: [*c]const u8, @"error": ?*DBusError) [*c]u8;
pub fn dbus_clear_address_entries(arg_pointer_to_entries: [*c][*c]?*DBusAddressEntry) callconv(.c) void {
    var pointer_to_entries = arg_pointer_to_entries;
    _ = &pointer_to_entries;
    while (true) {
        var _pp: [*c][*c]?*DBusAddressEntry = pointer_to_entries;
        _ = &_pp;
        var _value: [*c]?*DBusAddressEntry = _pp.*;
        _ = &_value;
        _pp.* = null;
        if (@as(?*anyopaque, @ptrCast(@alignCast(_value))) != @as(?*anyopaque, null)) {
            dbus_address_entries_free(_value);
        }
        if (!false) break;
    }
}
pub extern fn dbus_malloc(bytes: usize) ?*anyopaque;
pub extern fn dbus_malloc0(bytes: usize) ?*anyopaque;
pub extern fn dbus_realloc(memory: ?*anyopaque, bytes: usize) ?*anyopaque;
pub extern fn dbus_free(memory: ?*anyopaque) void;
pub extern fn dbus_free_string_array(str_array: [*c][*c]u8) void;
pub const DBusFreeFunction = ?*const fn (memory: ?*anyopaque) callconv(.c) void;
pub extern fn dbus_shutdown() void;
pub const struct_DBusMessage = opaque {
    pub const @"return" = dbus_message_new_method_return;
    pub const @"error" = dbus_message_new_error;
    pub const printf = dbus_message_new_error_printf;
    pub const copy = dbus_message_copy;
    pub const ref = dbus_message_ref;
    pub const unref = dbus_message_unref;
    pub const @"type" = dbus_message_get_type;
    pub const path = dbus_message_set_path;
    pub const path1 = dbus_message_get_path;
    pub const path2 = dbus_message_has_path;
    pub const interface = dbus_message_set_interface;
    pub const interface1 = dbus_message_get_interface;
    pub const interface2 = dbus_message_has_interface;
    pub const member = dbus_message_set_member;
    pub const member1 = dbus_message_get_member;
    pub const member2 = dbus_message_has_member;
    pub const name = dbus_message_set_error_name;
    pub const name1 = dbus_message_get_error_name;
    pub const destination = dbus_message_set_destination;
    pub const destination1 = dbus_message_get_destination;
    pub const sender = dbus_message_set_sender;
    pub const sender1 = dbus_message_get_sender;
    pub const signature = dbus_message_get_signature;
    pub const reply = dbus_message_set_no_reply;
    pub const reply1 = dbus_message_get_no_reply;
    pub const call = dbus_message_is_method_call;
    pub const signal = dbus_message_is_signal;
    pub const error1 = dbus_message_is_error;
    pub const destination2 = dbus_message_has_destination;
    pub const sender2 = dbus_message_has_sender;
    pub const signature1 = dbus_message_has_signature;
    pub const serial = dbus_message_get_serial;
    pub const serial1 = dbus_message_set_serial;
    pub const serial2 = dbus_message_set_reply_serial;
    pub const serial3 = dbus_message_get_reply_serial;
    pub const start = dbus_message_set_auto_start;
    pub const start1 = dbus_message_get_auto_start;
    pub const decomposed = dbus_message_get_path_decomposed;
    pub const instance = dbus_message_get_container_instance;
    pub const instance1 = dbus_message_set_container_instance;
    pub const args = dbus_message_append_args;
    pub const valist = dbus_message_append_args_valist;
    pub const args1 = dbus_message_get_args;
    pub const valist1 = dbus_message_get_args_valist;
    pub const fds = dbus_message_contains_unix_fds;
    pub const init = dbus_message_iter_init;
    pub const append = dbus_message_iter_init_append;
    pub const lock = dbus_message_lock;
    pub const data = dbus_message_set_data;
    pub const data1 = dbus_message_get_data;
    pub const marshal = dbus_message_marshal;
    pub const authorization = dbus_message_set_allow_interactive_authorization;
    pub const authorization1 = dbus_message_get_allow_interactive_authorization;
};
pub const DBusMessage = struct_DBusMessage;
pub const struct_DBusMessageIter = extern struct {
    dummy1: ?*anyopaque = null,
    dummy2: ?*anyopaque = null,
    dummy3: dbus_uint32_t = 0,
    dummy4: c_int = 0,
    dummy5: c_int = 0,
    dummy6: c_int = 0,
    dummy7: c_int = 0,
    dummy8: c_int = 0,
    dummy9: c_int = 0,
    dummy10: c_int = 0,
    dummy11: c_int = 0,
    pad1: c_int = 0,
    pad2: ?*anyopaque = null,
    pad3: ?*anyopaque = null,
    pub const closed = dbus_message_iter_init_closed;
    pub const next = dbus_message_iter_has_next;
    pub const next1 = dbus_message_iter_next;
    pub const signature = dbus_message_iter_get_signature;
    pub const @"type" = dbus_message_iter_get_arg_type;
    pub const type1 = dbus_message_iter_get_element_type;
    pub const recurse = dbus_message_iter_recurse;
    pub const basic = dbus_message_iter_get_basic;
    pub const count = dbus_message_iter_get_element_count;
    pub const len = dbus_message_iter_get_array_len;
    pub const array = dbus_message_iter_get_fixed_array;
    pub const basic1 = dbus_message_iter_append_basic;
    pub const array1 = dbus_message_iter_append_fixed_array;
    pub const container = dbus_message_iter_open_container;
    pub const container1 = dbus_message_iter_close_container;
    pub const container2 = dbus_message_iter_abandon_container;
    pub const open = dbus_message_iter_abandon_container_if_open;
};
pub const DBusMessageIter = struct_DBusMessageIter;
pub extern fn dbus_message_new(message_type: c_int) ?*DBusMessage;
pub extern fn dbus_message_new_method_call(bus_name: [*c]const u8, path: [*c]const u8, iface: [*c]const u8, method: [*c]const u8) ?*DBusMessage;
pub extern fn dbus_message_new_method_return(method_call: ?*DBusMessage) ?*DBusMessage;
pub extern fn dbus_message_new_signal(path: [*c]const u8, iface: [*c]const u8, name: [*c]const u8) ?*DBusMessage;
pub extern fn dbus_message_new_error(reply_to: ?*DBusMessage, error_name: [*c]const u8, error_message: [*c]const u8) ?*DBusMessage;
pub extern fn dbus_message_new_error_printf(reply_to: ?*DBusMessage, error_name: [*c]const u8, error_format: [*c]const u8, ...) ?*DBusMessage;
pub extern fn dbus_message_copy(message: ?*const DBusMessage) ?*DBusMessage;
pub extern fn dbus_message_ref(message: ?*DBusMessage) ?*DBusMessage;
pub extern fn dbus_message_unref(message: ?*DBusMessage) void;
pub extern fn dbus_message_get_type(message: ?*DBusMessage) c_int;
pub extern fn dbus_message_set_path(message: ?*DBusMessage, object_path: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_path(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_has_path(message: ?*DBusMessage, object_path: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_set_interface(message: ?*DBusMessage, iface: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_interface(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_has_interface(message: ?*DBusMessage, iface: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_set_member(message: ?*DBusMessage, member: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_member(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_has_member(message: ?*DBusMessage, member: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_set_error_name(message: ?*DBusMessage, name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_error_name(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_set_destination(message: ?*DBusMessage, destination: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_destination(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_set_sender(message: ?*DBusMessage, sender: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_sender(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_get_signature(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_set_no_reply(message: ?*DBusMessage, no_reply: dbus_bool_t) void;
pub extern fn dbus_message_get_no_reply(message: ?*DBusMessage) dbus_bool_t;
pub extern fn dbus_message_is_method_call(message: ?*DBusMessage, iface: [*c]const u8, method: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_is_signal(message: ?*DBusMessage, iface: [*c]const u8, signal_name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_is_error(message: ?*DBusMessage, error_name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_has_destination(message: ?*DBusMessage, bus_name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_has_sender(message: ?*DBusMessage, unique_bus_name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_has_signature(message: ?*DBusMessage, signature: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_get_serial(message: ?*DBusMessage) dbus_uint32_t;
pub extern fn dbus_message_set_serial(message: ?*DBusMessage, serial: dbus_uint32_t) void;
pub extern fn dbus_message_set_reply_serial(message: ?*DBusMessage, reply_serial: dbus_uint32_t) dbus_bool_t;
pub extern fn dbus_message_get_reply_serial(message: ?*DBusMessage) dbus_uint32_t;
pub extern fn dbus_message_set_auto_start(message: ?*DBusMessage, auto_start: dbus_bool_t) void;
pub extern fn dbus_message_get_auto_start(message: ?*DBusMessage) dbus_bool_t;
pub extern fn dbus_message_get_path_decomposed(message: ?*DBusMessage, path: [*c][*c][*c]u8) dbus_bool_t;
pub extern fn dbus_message_get_container_instance(message: ?*DBusMessage) [*c]const u8;
pub extern fn dbus_message_set_container_instance(message: ?*DBusMessage, object_path: [*c]const u8) dbus_bool_t;
pub extern fn dbus_message_append_args(message: ?*DBusMessage, first_arg_type: c_int, ...) dbus_bool_t;
pub extern fn dbus_message_append_args_valist(message: ?*DBusMessage, first_arg_type: c_int, var_args: [*c]struct___va_list_tag_1) dbus_bool_t;
pub extern fn dbus_message_get_args(message: ?*DBusMessage, @"error": ?*DBusError, first_arg_type: c_int, ...) dbus_bool_t;
pub extern fn dbus_message_get_args_valist(message: ?*DBusMessage, @"error": ?*DBusError, first_arg_type: c_int, var_args: [*c]struct___va_list_tag_1) dbus_bool_t;
pub extern fn dbus_message_contains_unix_fds(message: ?*DBusMessage) dbus_bool_t;
pub extern fn dbus_message_iter_init_closed(iter: [*c]DBusMessageIter) void;
pub extern fn dbus_message_iter_init(message: ?*DBusMessage, iter: [*c]DBusMessageIter) dbus_bool_t;
pub extern fn dbus_message_iter_has_next(iter: [*c]DBusMessageIter) dbus_bool_t;
pub extern fn dbus_message_iter_next(iter: [*c]DBusMessageIter) dbus_bool_t;
pub extern fn dbus_message_iter_get_signature(iter: [*c]DBusMessageIter) [*c]u8;
pub extern fn dbus_message_iter_get_arg_type(iter: [*c]DBusMessageIter) c_int;
pub extern fn dbus_message_iter_get_element_type(iter: [*c]DBusMessageIter) c_int;
pub extern fn dbus_message_iter_recurse(iter: [*c]DBusMessageIter, sub: [*c]DBusMessageIter) void;
pub extern fn dbus_message_iter_get_basic(iter: [*c]DBusMessageIter, value: ?*anyopaque) void;
pub extern fn dbus_message_iter_get_element_count(iter: [*c]DBusMessageIter) c_int;
pub extern fn dbus_message_iter_get_array_len(iter: [*c]DBusMessageIter) c_int;
pub extern fn dbus_message_iter_get_fixed_array(iter: [*c]DBusMessageIter, value: ?*anyopaque, n_elements: [*c]c_int) void;
pub extern fn dbus_message_iter_init_append(message: ?*DBusMessage, iter: [*c]DBusMessageIter) void;
pub extern fn dbus_message_iter_append_basic(iter: [*c]DBusMessageIter, @"type": c_int, value: ?*const anyopaque) dbus_bool_t;
pub extern fn dbus_message_iter_append_fixed_array(iter: [*c]DBusMessageIter, element_type: c_int, value: ?*const anyopaque, n_elements: c_int) dbus_bool_t;
pub extern fn dbus_message_iter_open_container(iter: [*c]DBusMessageIter, @"type": c_int, contained_signature: [*c]const u8, sub: [*c]DBusMessageIter) dbus_bool_t;
pub extern fn dbus_message_iter_close_container(iter: [*c]DBusMessageIter, sub: [*c]DBusMessageIter) dbus_bool_t;
pub extern fn dbus_message_iter_abandon_container(iter: [*c]DBusMessageIter, sub: [*c]DBusMessageIter) void;
pub extern fn dbus_message_iter_abandon_container_if_open(iter: [*c]DBusMessageIter, sub: [*c]DBusMessageIter) void;
pub extern fn dbus_message_lock(message: ?*DBusMessage) void;
pub extern fn dbus_set_error_from_message(@"error": ?*DBusError, message: ?*DBusMessage) dbus_bool_t;
pub extern fn dbus_message_allocate_data_slot(slot_p: [*c]dbus_int32_t) dbus_bool_t;
pub extern fn dbus_message_free_data_slot(slot_p: [*c]dbus_int32_t) void;
pub extern fn dbus_message_set_data(message: ?*DBusMessage, slot: dbus_int32_t, data: ?*anyopaque, free_data_func: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_message_get_data(message: ?*DBusMessage, slot: dbus_int32_t) ?*anyopaque;
pub extern fn dbus_message_type_from_string(type_str: [*c]const u8) c_int;
pub extern fn dbus_message_type_to_string(@"type": c_int) [*c]const u8;
pub extern fn dbus_message_marshal(msg: ?*DBusMessage, marshalled_data_p: [*c][*c]u8, len_p: [*c]c_int) dbus_bool_t;
pub extern fn dbus_message_demarshal(str: [*c]const u8, len: c_int, @"error": ?*DBusError) ?*DBusMessage;
pub extern fn dbus_message_demarshal_bytes_needed(str: [*c]const u8, len: c_int) c_int;
pub extern fn dbus_message_set_allow_interactive_authorization(message: ?*DBusMessage, allow: dbus_bool_t) void;
pub extern fn dbus_message_get_allow_interactive_authorization(message: ?*DBusMessage) dbus_bool_t;
pub fn dbus_clear_message(arg_pointer_to_message: [*c]?*DBusMessage) callconv(.c) void {
    var pointer_to_message = arg_pointer_to_message;
    _ = &pointer_to_message;
    while (true) {
        var _pp: [*c]?*DBusMessage = pointer_to_message;
        _ = &_pp;
        var _value: ?*DBusMessage = _pp.*;
        _ = &_value;
        _pp.* = null;
        if (@as(?*anyopaque, @ptrCast(@alignCast(_value))) != @as(?*anyopaque, null)) {
            dbus_message_unref(_value);
        }
        if (!false) break;
    }
}
pub const DBUS_BUS_SESSION: c_int = 0;
pub const DBUS_BUS_SYSTEM: c_int = 1;
pub const DBUS_BUS_STARTER: c_int = 2;
pub const DBusBusType = c_uint;
pub const DBUS_HANDLER_RESULT_HANDLED: c_int = 0;
pub const DBUS_HANDLER_RESULT_NOT_YET_HANDLED: c_int = 1;
pub const DBUS_HANDLER_RESULT_NEED_MEMORY: c_int = 2;
pub const DBusHandlerResult = c_uint;
pub const struct_DBusWatch = opaque {
    pub const fd = dbus_watch_get_fd;
    pub const fd1 = dbus_watch_get_unix_fd;
    pub const socket = dbus_watch_get_socket;
    pub const flags = dbus_watch_get_flags;
    pub const data = dbus_watch_get_data;
    pub const data1 = dbus_watch_set_data;
    pub const handle = dbus_watch_handle;
    pub const enabled = dbus_watch_get_enabled;
};
pub const DBusWatch = struct_DBusWatch;
pub const struct_DBusTimeout = opaque {
    pub const interval = dbus_timeout_get_interval;
    pub const data = dbus_timeout_get_data;
    pub const data1 = dbus_timeout_set_data;
    pub const handle = dbus_timeout_handle;
    pub const enabled = dbus_timeout_get_enabled;
};
pub const DBusTimeout = struct_DBusTimeout;
pub const struct_DBusPreallocatedSend = opaque {};
pub const DBusPreallocatedSend = struct_DBusPreallocatedSend;
pub const struct_DBusPendingCall = opaque {
    pub const ref = dbus_pending_call_ref;
    pub const unref = dbus_pending_call_unref;
    pub const notify = dbus_pending_call_set_notify;
    pub const cancel = dbus_pending_call_cancel;
    pub const completed = dbus_pending_call_get_completed;
    pub const reply = dbus_pending_call_steal_reply;
    pub const block = dbus_pending_call_block;
    pub const data = dbus_pending_call_set_data;
    pub const data1 = dbus_pending_call_get_data;
};
pub const DBusPendingCall = struct_DBusPendingCall;
pub const struct_DBusConnection = opaque {
    pub const ref = dbus_connection_ref;
    pub const unref = dbus_connection_unref;
    pub const close = dbus_connection_close;
    pub const connected = dbus_connection_get_is_connected;
    pub const authenticated = dbus_connection_get_is_authenticated;
    pub const anonymous = dbus_connection_get_is_anonymous;
    pub const id = dbus_connection_get_server_id;
    pub const @"type" = dbus_connection_can_send_type;
    pub const disconnect = dbus_connection_set_exit_on_disconnect;
    pub const flush = dbus_connection_flush;
    pub const dispatch = dbus_connection_read_write_dispatch;
    pub const write = dbus_connection_read_write;
    pub const message = dbus_connection_borrow_message;
    pub const message1 = dbus_connection_return_message;
    pub const message2 = dbus_connection_steal_borrowed_message;
    pub const message3 = dbus_connection_pop_message;
    pub const status = dbus_connection_get_dispatch_status;
    pub const dispatch1 = dbus_connection_dispatch;
    pub const send = dbus_connection_has_messages_to_send;
    pub const send1 = dbus_connection_send;
    pub const reply = dbus_connection_send_with_reply;
    pub const block = dbus_connection_send_with_reply_and_block;
    pub const functions = dbus_connection_set_watch_functions;
    pub const functions1 = dbus_connection_set_timeout_functions;
    pub const function = dbus_connection_set_wakeup_main_function;
    pub const function1 = dbus_connection_set_dispatch_status_function;
    pub const user = dbus_connection_get_unix_user;
    pub const id1 = dbus_connection_get_unix_process_id;
    pub const data = dbus_connection_get_adt_audit_session_data;
    pub const function2 = dbus_connection_set_unix_user_function;
    pub const user1 = dbus_connection_get_windows_user;
    pub const function3 = dbus_connection_set_windows_user_function;
    pub const anonymous1 = dbus_connection_set_allow_anonymous;
    pub const enabled = dbus_connection_set_builtin_filters_enabled;
    pub const messages = dbus_connection_set_route_peer_messages;
    pub const filter = dbus_connection_add_filter;
    pub const filter1 = dbus_connection_remove_filter;
    pub const data1 = dbus_connection_set_data;
    pub const data2 = dbus_connection_get_data;
    pub const size = dbus_connection_set_max_message_size;
    pub const size1 = dbus_connection_get_max_message_size;
    pub const size2 = dbus_connection_set_max_received_size;
    pub const size3 = dbus_connection_get_max_received_size;
    pub const fds = dbus_connection_set_max_message_unix_fds;
    pub const fds1 = dbus_connection_get_max_message_unix_fds;
    pub const fds2 = dbus_connection_set_max_received_unix_fds;
    pub const fds3 = dbus_connection_get_max_received_unix_fds;
    pub const size4 = dbus_connection_get_outgoing_size;
    pub const fds4 = dbus_connection_get_outgoing_unix_fds;
    pub const send2 = dbus_connection_preallocate_send;
    pub const send3 = dbus_connection_free_preallocated_send;
    pub const preallocated = dbus_connection_send_preallocated;
    pub const path = dbus_connection_try_register_object_path;
    pub const path1 = dbus_connection_register_object_path;
    pub const fallback = dbus_connection_try_register_fallback;
    pub const fallback1 = dbus_connection_register_fallback;
    pub const path2 = dbus_connection_unregister_object_path;
    pub const data3 = dbus_connection_get_object_path_data;
    pub const registered = dbus_connection_list_registered;
    pub const fd = dbus_connection_get_unix_fd;
    pub const socket = dbus_connection_get_socket;
    pub const register = dbus_bus_register;
    pub const name = dbus_bus_set_unique_name;
    pub const name1 = dbus_bus_get_unique_name;
    pub const user2 = dbus_bus_get_unix_user;
    pub const id2 = dbus_bus_get_id;
    pub const name2 = dbus_bus_request_name;
    pub const name3 = dbus_bus_release_name;
    pub const owner = dbus_bus_name_has_owner;
    pub const name4 = dbus_bus_start_service_by_name;
    pub const match = dbus_bus_add_match;
    pub const match1 = dbus_bus_remove_match;
};
pub const DBusConnection = struct_DBusConnection;
pub const DBusObjectPathUnregisterFunction = ?*const fn (connection: ?*DBusConnection, user_data: ?*anyopaque) callconv(.c) void;
pub const DBusObjectPathMessageFunction = ?*const fn (connection: ?*DBusConnection, message: ?*DBusMessage, user_data: ?*anyopaque) callconv(.c) DBusHandlerResult;
pub const struct_DBusObjectPathVTable = extern struct {
    unregister_function: DBusObjectPathUnregisterFunction = null,
    message_function: DBusObjectPathMessageFunction = null,
    dbus_internal_pad1: ?*const fn (?*anyopaque) callconv(.c) void = null,
    dbus_internal_pad2: ?*const fn (?*anyopaque) callconv(.c) void = null,
    dbus_internal_pad3: ?*const fn (?*anyopaque) callconv(.c) void = null,
    dbus_internal_pad4: ?*const fn (?*anyopaque) callconv(.c) void = null,
};
pub const DBusObjectPathVTable = struct_DBusObjectPathVTable;
pub const DBUS_WATCH_READABLE: c_int = 1;
pub const DBUS_WATCH_WRITABLE: c_int = 2;
pub const DBUS_WATCH_ERROR: c_int = 4;
pub const DBUS_WATCH_HANGUP: c_int = 8;
pub const DBusWatchFlags = c_uint;
pub const DBUS_DISPATCH_DATA_REMAINS: c_int = 0;
pub const DBUS_DISPATCH_COMPLETE: c_int = 1;
pub const DBUS_DISPATCH_NEED_MEMORY: c_int = 2;
pub const DBusDispatchStatus = c_uint;
pub const DBusAddWatchFunction = ?*const fn (watch: ?*DBusWatch, data: ?*anyopaque) callconv(.c) dbus_bool_t;
pub const DBusWatchToggledFunction = ?*const fn (watch: ?*DBusWatch, data: ?*anyopaque) callconv(.c) void;
pub const DBusRemoveWatchFunction = ?*const fn (watch: ?*DBusWatch, data: ?*anyopaque) callconv(.c) void;
pub const DBusAddTimeoutFunction = ?*const fn (timeout: ?*DBusTimeout, data: ?*anyopaque) callconv(.c) dbus_bool_t;
pub const DBusTimeoutToggledFunction = ?*const fn (timeout: ?*DBusTimeout, data: ?*anyopaque) callconv(.c) void;
pub const DBusRemoveTimeoutFunction = ?*const fn (timeout: ?*DBusTimeout, data: ?*anyopaque) callconv(.c) void;
pub const DBusDispatchStatusFunction = ?*const fn (connection: ?*DBusConnection, new_status: DBusDispatchStatus, data: ?*anyopaque) callconv(.c) void;
pub const DBusWakeupMainFunction = ?*const fn (data: ?*anyopaque) callconv(.c) void;
pub const DBusAllowUnixUserFunction = ?*const fn (connection: ?*DBusConnection, uid: c_ulong, data: ?*anyopaque) callconv(.c) dbus_bool_t;
pub const DBusAllowWindowsUserFunction = ?*const fn (connection: ?*DBusConnection, user_sid: [*c]const u8, data: ?*anyopaque) callconv(.c) dbus_bool_t;
pub const DBusPendingCallNotifyFunction = ?*const fn (pending: ?*DBusPendingCall, user_data: ?*anyopaque) callconv(.c) void;
pub const DBusHandleMessageFunction = ?*const fn (connection: ?*DBusConnection, message: ?*DBusMessage, user_data: ?*anyopaque) callconv(.c) DBusHandlerResult;
pub extern fn dbus_connection_open(address: [*c]const u8, @"error": ?*DBusError) ?*DBusConnection;
pub extern fn dbus_connection_open_private(address: [*c]const u8, @"error": ?*DBusError) ?*DBusConnection;
pub extern fn dbus_connection_ref(connection: ?*DBusConnection) ?*DBusConnection;
pub extern fn dbus_connection_unref(connection: ?*DBusConnection) void;
pub extern fn dbus_connection_close(connection: ?*DBusConnection) void;
pub extern fn dbus_connection_get_is_connected(connection: ?*DBusConnection) dbus_bool_t;
pub extern fn dbus_connection_get_is_authenticated(connection: ?*DBusConnection) dbus_bool_t;
pub extern fn dbus_connection_get_is_anonymous(connection: ?*DBusConnection) dbus_bool_t;
pub extern fn dbus_connection_get_server_id(connection: ?*DBusConnection) [*c]u8;
pub extern fn dbus_connection_can_send_type(connection: ?*DBusConnection, @"type": c_int) dbus_bool_t;
pub extern fn dbus_connection_set_exit_on_disconnect(connection: ?*DBusConnection, exit_on_disconnect: dbus_bool_t) void;
pub extern fn dbus_connection_flush(connection: ?*DBusConnection) void;
pub extern fn dbus_connection_read_write_dispatch(connection: ?*DBusConnection, timeout_milliseconds: c_int) dbus_bool_t;
pub extern fn dbus_connection_read_write(connection: ?*DBusConnection, timeout_milliseconds: c_int) dbus_bool_t;
pub extern fn dbus_connection_borrow_message(connection: ?*DBusConnection) ?*DBusMessage;
pub extern fn dbus_connection_return_message(connection: ?*DBusConnection, message: ?*DBusMessage) void;
pub extern fn dbus_connection_steal_borrowed_message(connection: ?*DBusConnection, message: ?*DBusMessage) void;
pub extern fn dbus_connection_pop_message(connection: ?*DBusConnection) ?*DBusMessage;
pub extern fn dbus_connection_get_dispatch_status(connection: ?*DBusConnection) DBusDispatchStatus;
pub extern fn dbus_connection_dispatch(connection: ?*DBusConnection) DBusDispatchStatus;
pub extern fn dbus_connection_has_messages_to_send(connection: ?*DBusConnection) dbus_bool_t;
pub extern fn dbus_connection_send(connection: ?*DBusConnection, message: ?*DBusMessage, client_serial: [*c]dbus_uint32_t) dbus_bool_t;
pub extern fn dbus_connection_send_with_reply(connection: ?*DBusConnection, message: ?*DBusMessage, pending_return: [*c]?*DBusPendingCall, timeout_milliseconds: c_int) dbus_bool_t;
pub extern fn dbus_connection_send_with_reply_and_block(connection: ?*DBusConnection, message: ?*DBusMessage, timeout_milliseconds: c_int, @"error": ?*DBusError) ?*DBusMessage;
pub extern fn dbus_connection_set_watch_functions(connection: ?*DBusConnection, add_function: DBusAddWatchFunction, remove_function: DBusRemoveWatchFunction, toggled_function: DBusWatchToggledFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_connection_set_timeout_functions(connection: ?*DBusConnection, add_function: DBusAddTimeoutFunction, remove_function: DBusRemoveTimeoutFunction, toggled_function: DBusTimeoutToggledFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_connection_set_wakeup_main_function(connection: ?*DBusConnection, wakeup_main_function: DBusWakeupMainFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_connection_set_dispatch_status_function(connection: ?*DBusConnection, function: DBusDispatchStatusFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_connection_get_unix_user(connection: ?*DBusConnection, uid: [*c]c_ulong) dbus_bool_t;
pub extern fn dbus_connection_get_unix_process_id(connection: ?*DBusConnection, pid: [*c]c_ulong) dbus_bool_t;
pub extern fn dbus_connection_get_adt_audit_session_data(connection: ?*DBusConnection, data: [*c]?*anyopaque, data_size: [*c]dbus_int32_t) dbus_bool_t;
pub extern fn dbus_connection_set_unix_user_function(connection: ?*DBusConnection, function: DBusAllowUnixUserFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_connection_get_windows_user(connection: ?*DBusConnection, windows_sid_p: [*c][*c]u8) dbus_bool_t;
pub extern fn dbus_connection_set_windows_user_function(connection: ?*DBusConnection, function: DBusAllowWindowsUserFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_connection_set_allow_anonymous(connection: ?*DBusConnection, value: dbus_bool_t) void;
pub extern fn dbus_connection_set_builtin_filters_enabled(connection: ?*DBusConnection, value: dbus_bool_t) void;
pub extern fn dbus_connection_set_route_peer_messages(connection: ?*DBusConnection, value: dbus_bool_t) void;
pub extern fn dbus_connection_add_filter(connection: ?*DBusConnection, function: DBusHandleMessageFunction, user_data: ?*anyopaque, free_data_function: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_connection_remove_filter(connection: ?*DBusConnection, function: DBusHandleMessageFunction, user_data: ?*anyopaque) void;
pub extern fn dbus_connection_allocate_data_slot(slot_p: [*c]dbus_int32_t) dbus_bool_t;
pub extern fn dbus_connection_free_data_slot(slot_p: [*c]dbus_int32_t) void;
pub extern fn dbus_connection_set_data(connection: ?*DBusConnection, slot: dbus_int32_t, data: ?*anyopaque, free_data_func: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_connection_get_data(connection: ?*DBusConnection, slot: dbus_int32_t) ?*anyopaque;
pub extern fn dbus_connection_set_change_sigpipe(will_modify_sigpipe: dbus_bool_t) void;
pub extern fn dbus_connection_set_max_message_size(connection: ?*DBusConnection, size: c_long) void;
pub extern fn dbus_connection_get_max_message_size(connection: ?*DBusConnection) c_long;
pub extern fn dbus_connection_set_max_received_size(connection: ?*DBusConnection, size: c_long) void;
pub extern fn dbus_connection_get_max_received_size(connection: ?*DBusConnection) c_long;
pub extern fn dbus_connection_set_max_message_unix_fds(connection: ?*DBusConnection, n: c_long) void;
pub extern fn dbus_connection_get_max_message_unix_fds(connection: ?*DBusConnection) c_long;
pub extern fn dbus_connection_set_max_received_unix_fds(connection: ?*DBusConnection, n: c_long) void;
pub extern fn dbus_connection_get_max_received_unix_fds(connection: ?*DBusConnection) c_long;
pub extern fn dbus_connection_get_outgoing_size(connection: ?*DBusConnection) c_long;
pub extern fn dbus_connection_get_outgoing_unix_fds(connection: ?*DBusConnection) c_long;
pub extern fn dbus_connection_preallocate_send(connection: ?*DBusConnection) ?*DBusPreallocatedSend;
pub extern fn dbus_connection_free_preallocated_send(connection: ?*DBusConnection, preallocated: ?*DBusPreallocatedSend) void;
pub extern fn dbus_connection_send_preallocated(connection: ?*DBusConnection, preallocated: ?*DBusPreallocatedSend, message: ?*DBusMessage, client_serial: [*c]dbus_uint32_t) void;
pub extern fn dbus_connection_try_register_object_path(connection: ?*DBusConnection, path: [*c]const u8, vtable: [*c]const DBusObjectPathVTable, user_data: ?*anyopaque, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_connection_register_object_path(connection: ?*DBusConnection, path: [*c]const u8, vtable: [*c]const DBusObjectPathVTable, user_data: ?*anyopaque) dbus_bool_t;
pub extern fn dbus_connection_try_register_fallback(connection: ?*DBusConnection, path: [*c]const u8, vtable: [*c]const DBusObjectPathVTable, user_data: ?*anyopaque, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_connection_register_fallback(connection: ?*DBusConnection, path: [*c]const u8, vtable: [*c]const DBusObjectPathVTable, user_data: ?*anyopaque) dbus_bool_t;
pub extern fn dbus_connection_unregister_object_path(connection: ?*DBusConnection, path: [*c]const u8) dbus_bool_t;
pub extern fn dbus_connection_get_object_path_data(connection: ?*DBusConnection, path: [*c]const u8, data_p: [*c]?*anyopaque) dbus_bool_t;
pub extern fn dbus_connection_list_registered(connection: ?*DBusConnection, parent_path: [*c]const u8, child_entries: [*c][*c][*c]u8) dbus_bool_t;
pub extern fn dbus_connection_get_unix_fd(connection: ?*DBusConnection, fd: [*c]c_int) dbus_bool_t;
pub extern fn dbus_connection_get_socket(connection: ?*DBusConnection, fd: [*c]c_int) dbus_bool_t;
pub fn dbus_clear_connection(arg_pointer_to_connection: [*c]?*DBusConnection) callconv(.c) void {
    var pointer_to_connection = arg_pointer_to_connection;
    _ = &pointer_to_connection;
    while (true) {
        var _pp: [*c]?*DBusConnection = pointer_to_connection;
        _ = &_pp;
        var _value: ?*DBusConnection = _pp.*;
        _ = &_value;
        _pp.* = null;
        if (@as(?*anyopaque, @ptrCast(@alignCast(_value))) != @as(?*anyopaque, null)) {
            dbus_connection_unref(_value);
        }
        if (!false) break;
    }
}
pub extern fn dbus_watch_get_fd(watch: ?*DBusWatch) c_int;
pub extern fn dbus_watch_get_unix_fd(watch: ?*DBusWatch) c_int;
pub extern fn dbus_watch_get_socket(watch: ?*DBusWatch) c_int;
pub extern fn dbus_watch_get_flags(watch: ?*DBusWatch) c_uint;
pub extern fn dbus_watch_get_data(watch: ?*DBusWatch) ?*anyopaque;
pub extern fn dbus_watch_set_data(watch: ?*DBusWatch, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_watch_handle(watch: ?*DBusWatch, flags: c_uint) dbus_bool_t;
pub extern fn dbus_watch_get_enabled(watch: ?*DBusWatch) dbus_bool_t;
pub extern fn dbus_timeout_get_interval(timeout: ?*DBusTimeout) c_int;
pub extern fn dbus_timeout_get_data(timeout: ?*DBusTimeout) ?*anyopaque;
pub extern fn dbus_timeout_set_data(timeout: ?*DBusTimeout, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_timeout_handle(timeout: ?*DBusTimeout) dbus_bool_t;
pub extern fn dbus_timeout_get_enabled(timeout: ?*DBusTimeout) dbus_bool_t;
pub extern fn dbus_bus_get(@"type": DBusBusType, @"error": ?*DBusError) ?*DBusConnection;
pub extern fn dbus_bus_get_private(@"type": DBusBusType, @"error": ?*DBusError) ?*DBusConnection;
pub extern fn dbus_bus_register(connection: ?*DBusConnection, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_bus_set_unique_name(connection: ?*DBusConnection, unique_name: [*c]const u8) dbus_bool_t;
pub extern fn dbus_bus_get_unique_name(connection: ?*DBusConnection) [*c]const u8;
pub extern fn dbus_bus_get_unix_user(connection: ?*DBusConnection, name: [*c]const u8, @"error": ?*DBusError) c_ulong;
pub extern fn dbus_bus_get_id(connection: ?*DBusConnection, @"error": ?*DBusError) [*c]u8;
pub extern fn dbus_bus_request_name(connection: ?*DBusConnection, name: [*c]const u8, flags: c_uint, @"error": ?*DBusError) c_int;
pub extern fn dbus_bus_release_name(connection: ?*DBusConnection, name: [*c]const u8, @"error": ?*DBusError) c_int;
pub extern fn dbus_bus_name_has_owner(connection: ?*DBusConnection, name: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_bus_start_service_by_name(connection: ?*DBusConnection, name: [*c]const u8, flags: dbus_uint32_t, reply: [*c]dbus_uint32_t, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_bus_add_match(connection: ?*DBusConnection, rule: [*c]const u8, @"error": ?*DBusError) void;
pub extern fn dbus_bus_remove_match(connection: ?*DBusConnection, rule: [*c]const u8, @"error": ?*DBusError) void;
pub extern fn dbus_get_local_machine_id() [*c]u8;
pub extern fn dbus_get_version(major_version_p: [*c]c_int, minor_version_p: [*c]c_int, micro_version_p: [*c]c_int) void;
pub extern fn dbus_setenv(variable: [*c]const u8, value: [*c]const u8) dbus_bool_t;
pub extern fn dbus_try_get_local_machine_id(@"error": ?*DBusError) [*c]u8;
pub extern fn dbus_pending_call_ref(pending: ?*DBusPendingCall) ?*DBusPendingCall;
pub extern fn dbus_pending_call_unref(pending: ?*DBusPendingCall) void;
pub extern fn dbus_pending_call_set_notify(pending: ?*DBusPendingCall, function: DBusPendingCallNotifyFunction, user_data: ?*anyopaque, free_user_data: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_pending_call_cancel(pending: ?*DBusPendingCall) void;
pub extern fn dbus_pending_call_get_completed(pending: ?*DBusPendingCall) dbus_bool_t;
pub extern fn dbus_pending_call_steal_reply(pending: ?*DBusPendingCall) ?*DBusMessage;
pub extern fn dbus_pending_call_block(pending: ?*DBusPendingCall) void;
pub extern fn dbus_pending_call_allocate_data_slot(slot_p: [*c]dbus_int32_t) dbus_bool_t;
pub extern fn dbus_pending_call_free_data_slot(slot_p: [*c]dbus_int32_t) void;
pub extern fn dbus_pending_call_set_data(pending: ?*DBusPendingCall, slot: dbus_int32_t, data: ?*anyopaque, free_data_func: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_pending_call_get_data(pending: ?*DBusPendingCall, slot: dbus_int32_t) ?*anyopaque;
pub fn dbus_clear_pending_call(arg_pointer_to_pending_call: [*c]?*DBusPendingCall) callconv(.c) void {
    var pointer_to_pending_call = arg_pointer_to_pending_call;
    _ = &pointer_to_pending_call;
    while (true) {
        var _pp: [*c]?*DBusPendingCall = pointer_to_pending_call;
        _ = &_pp;
        var _value: ?*DBusPendingCall = _pp.*;
        _ = &_value;
        _pp.* = null;
        if (@as(?*anyopaque, @ptrCast(@alignCast(_value))) != @as(?*anyopaque, null)) {
            dbus_pending_call_unref(_value);
        }
        if (!false) break;
    }
}
pub const struct_DBusServer = opaque {
    pub const ref = dbus_server_ref;
    pub const unref = dbus_server_unref;
    pub const disconnect = dbus_server_disconnect;
    pub const connected = dbus_server_get_is_connected;
    pub const address = dbus_server_get_address;
    pub const id = dbus_server_get_id;
    pub const function = dbus_server_set_new_connection_function;
    pub const functions = dbus_server_set_watch_functions;
    pub const functions1 = dbus_server_set_timeout_functions;
    pub const mechanisms = dbus_server_set_auth_mechanisms;
    pub const data = dbus_server_set_data;
    pub const data1 = dbus_server_get_data;
};
pub const DBusServer = struct_DBusServer;
pub const DBusNewConnectionFunction = ?*const fn (server: ?*DBusServer, new_connection: ?*DBusConnection, data: ?*anyopaque) callconv(.c) void;
pub extern fn dbus_server_listen(address: [*c]const u8, @"error": ?*DBusError) ?*DBusServer;
pub extern fn dbus_server_ref(server: ?*DBusServer) ?*DBusServer;
pub extern fn dbus_server_unref(server: ?*DBusServer) void;
pub extern fn dbus_server_disconnect(server: ?*DBusServer) void;
pub extern fn dbus_server_get_is_connected(server: ?*DBusServer) dbus_bool_t;
pub extern fn dbus_server_get_address(server: ?*DBusServer) [*c]u8;
pub extern fn dbus_server_get_id(server: ?*DBusServer) [*c]u8;
pub extern fn dbus_server_set_new_connection_function(server: ?*DBusServer, function: DBusNewConnectionFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) void;
pub extern fn dbus_server_set_watch_functions(server: ?*DBusServer, add_function: DBusAddWatchFunction, remove_function: DBusRemoveWatchFunction, toggled_function: DBusWatchToggledFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_server_set_timeout_functions(server: ?*DBusServer, add_function: DBusAddTimeoutFunction, remove_function: DBusRemoveTimeoutFunction, toggled_function: DBusTimeoutToggledFunction, data: ?*anyopaque, free_data_function: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_server_set_auth_mechanisms(server: ?*DBusServer, mechanisms: [*c][*c]const u8) dbus_bool_t;
pub extern fn dbus_server_allocate_data_slot(slot_p: [*c]dbus_int32_t) dbus_bool_t;
pub extern fn dbus_server_free_data_slot(slot_p: [*c]dbus_int32_t) void;
pub extern fn dbus_server_set_data(server: ?*DBusServer, slot: c_int, data: ?*anyopaque, free_data_func: DBusFreeFunction) dbus_bool_t;
pub extern fn dbus_server_get_data(server: ?*DBusServer, slot: c_int) ?*anyopaque;
pub fn dbus_clear_server(arg_pointer_to_server: [*c]?*DBusServer) callconv(.c) void {
    var pointer_to_server = arg_pointer_to_server;
    _ = &pointer_to_server;
    while (true) {
        var _pp: [*c]?*DBusServer = pointer_to_server;
        _ = &_pp;
        var _value: ?*DBusServer = _pp.*;
        _ = &_value;
        _pp.* = null;
        if (@as(?*anyopaque, @ptrCast(@alignCast(_value))) != @as(?*anyopaque, null)) {
            dbus_server_unref(_value);
        }
        if (!false) break;
    }
}
pub const DBusSignatureIter = extern struct {
    dummy1: ?*anyopaque = null,
    dummy2: ?*anyopaque = null,
    dummy8: dbus_uint32_t = 0,
    dummy12: c_int = 0,
    dummy17: c_int = 0,
    pub const init = dbus_signature_iter_init;
    pub const @"type" = dbus_signature_iter_get_current_type;
    pub const signature = dbus_signature_iter_get_signature;
    pub const type1 = dbus_signature_iter_get_element_type;
    pub const next = dbus_signature_iter_next;
    pub const recurse = dbus_signature_iter_recurse;
};
pub extern fn dbus_signature_iter_init(iter: [*c]DBusSignatureIter, signature: [*c]const u8) void;
pub extern fn dbus_signature_iter_get_current_type(iter: [*c]const DBusSignatureIter) c_int;
pub extern fn dbus_signature_iter_get_signature(iter: [*c]const DBusSignatureIter) [*c]u8;
pub extern fn dbus_signature_iter_get_element_type(iter: [*c]const DBusSignatureIter) c_int;
pub extern fn dbus_signature_iter_next(iter: [*c]DBusSignatureIter) dbus_bool_t;
pub extern fn dbus_signature_iter_recurse(iter: [*c]const DBusSignatureIter, subiter: [*c]DBusSignatureIter) void;
pub extern fn dbus_signature_validate(signature: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_signature_validate_single(signature: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_type_is_valid(typecode: c_int) dbus_bool_t;
pub extern fn dbus_type_is_basic(typecode: c_int) dbus_bool_t;
pub extern fn dbus_type_is_container(typecode: c_int) dbus_bool_t;
pub extern fn dbus_type_is_fixed(typecode: c_int) dbus_bool_t;
pub extern fn dbus_validate_path(path: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_validate_interface(name: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_validate_member(name: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_validate_error_name(name: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_validate_bus_name(name: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub extern fn dbus_validate_utf8(alleged_utf8: [*c]const u8, @"error": ?*DBusError) dbus_bool_t;
pub const struct_DBusMutex = opaque {};
pub const DBusMutex = struct_DBusMutex;
pub const struct_DBusCondVar = opaque {};
pub const DBusCondVar = struct_DBusCondVar;
pub const DBusMutexNewFunction = ?*const fn () callconv(.c) ?*DBusMutex;
pub const DBusMutexFreeFunction = ?*const fn (mutex: ?*DBusMutex) callconv(.c) void;
pub const DBusMutexLockFunction = ?*const fn (mutex: ?*DBusMutex) callconv(.c) dbus_bool_t;
pub const DBusMutexUnlockFunction = ?*const fn (mutex: ?*DBusMutex) callconv(.c) dbus_bool_t;
pub const DBusRecursiveMutexNewFunction = ?*const fn () callconv(.c) ?*DBusMutex;
pub const DBusRecursiveMutexFreeFunction = ?*const fn (mutex: ?*DBusMutex) callconv(.c) void;
pub const DBusRecursiveMutexLockFunction = ?*const fn (mutex: ?*DBusMutex) callconv(.c) void;
pub const DBusRecursiveMutexUnlockFunction = ?*const fn (mutex: ?*DBusMutex) callconv(.c) void;
pub const DBusCondVarNewFunction = ?*const fn () callconv(.c) ?*DBusCondVar;
pub const DBusCondVarFreeFunction = ?*const fn (cond: ?*DBusCondVar) callconv(.c) void;
pub const DBusCondVarWaitFunction = ?*const fn (cond: ?*DBusCondVar, mutex: ?*DBusMutex) callconv(.c) void;
pub const DBusCondVarWaitTimeoutFunction = ?*const fn (cond: ?*DBusCondVar, mutex: ?*DBusMutex, timeout_milliseconds: c_int) callconv(.c) dbus_bool_t;
pub const DBusCondVarWakeOneFunction = ?*const fn (cond: ?*DBusCondVar) callconv(.c) void;
pub const DBusCondVarWakeAllFunction = ?*const fn (cond: ?*DBusCondVar) callconv(.c) void;
pub const DBUS_THREAD_FUNCTIONS_MUTEX_NEW_MASK: c_int = 1;
pub const DBUS_THREAD_FUNCTIONS_MUTEX_FREE_MASK: c_int = 2;
pub const DBUS_THREAD_FUNCTIONS_MUTEX_LOCK_MASK: c_int = 4;
pub const DBUS_THREAD_FUNCTIONS_MUTEX_UNLOCK_MASK: c_int = 8;
pub const DBUS_THREAD_FUNCTIONS_CONDVAR_NEW_MASK: c_int = 16;
pub const DBUS_THREAD_FUNCTIONS_CONDVAR_FREE_MASK: c_int = 32;
pub const DBUS_THREAD_FUNCTIONS_CONDVAR_WAIT_MASK: c_int = 64;
pub const DBUS_THREAD_FUNCTIONS_CONDVAR_WAIT_TIMEOUT_MASK: c_int = 128;
pub const DBUS_THREAD_FUNCTIONS_CONDVAR_WAKE_ONE_MASK: c_int = 256;
pub const DBUS_THREAD_FUNCTIONS_CONDVAR_WAKE_ALL_MASK: c_int = 512;
pub const DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_NEW_MASK: c_int = 1024;
pub const DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_FREE_MASK: c_int = 2048;
pub const DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_LOCK_MASK: c_int = 4096;
pub const DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_UNLOCK_MASK: c_int = 8192;
pub const DBUS_THREAD_FUNCTIONS_ALL_MASK: c_int = 16383;
pub const DBusThreadFunctionsMask = c_uint;
pub const DBusThreadFunctions = extern struct {
    mask: c_uint = 0,
    mutex_new: DBusMutexNewFunction = null,
    mutex_free: DBusMutexFreeFunction = null,
    mutex_lock: DBusMutexLockFunction = null,
    mutex_unlock: DBusMutexUnlockFunction = null,
    condvar_new: DBusCondVarNewFunction = null,
    condvar_free: DBusCondVarFreeFunction = null,
    condvar_wait: DBusCondVarWaitFunction = null,
    condvar_wait_timeout: DBusCondVarWaitTimeoutFunction = null,
    condvar_wake_one: DBusCondVarWakeOneFunction = null,
    condvar_wake_all: DBusCondVarWakeAllFunction = null,
    recursive_mutex_new: DBusRecursiveMutexNewFunction = null,
    recursive_mutex_free: DBusRecursiveMutexFreeFunction = null,
    recursive_mutex_lock: DBusRecursiveMutexLockFunction = null,
    recursive_mutex_unlock: DBusRecursiveMutexUnlockFunction = null,
    padding1: ?*const fn () callconv(.c) void = null,
    padding2: ?*const fn () callconv(.c) void = null,
    padding3: ?*const fn () callconv(.c) void = null,
    padding4: ?*const fn () callconv(.c) void = null,
    pub const init = dbus_threads_init;
};
pub extern fn dbus_threads_init(functions: [*c]const DBusThreadFunctions) dbus_bool_t;
pub extern fn dbus_threads_init_default() dbus_bool_t;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:31:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:32:9
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __EVEX512__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512DQ__ = @as(c_int, 1);
pub const __AVX512BITALG__ = @as(c_int, 1);
pub const __AVX512BW__ = @as(c_int, 1);
pub const __AVX512VL__ = @as(c_int, 1);
pub const __EVEX256__ = @as(c_int, 1);
pub const __AVX512VBMI__ = @as(c_int, 1);
pub const __AVX512VBMI2__ = @as(c_int, 1);
pub const __AVX512IFMA__ = @as(c_int, 1);
pub const __AVX512VP2INTERSECT__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __PKU__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __SHSTK__ = @as(c_int, 1);
pub const __KL__ = @as(c_int, 1);
pub const __WIDEKL__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __MOVDIRI__ = @as(c_int, 1);
pub const __MOVDIR64B__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:162:9
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:164:9
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:185:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // <builtin>:207:9
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:215:9
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __pic__ = @as(c_int, 2);
pub const __PIC__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 42);
pub const SQLITE3_H = "";
pub const __STDC_VERSION_STDARG_H__ = @as(c_int, 0);
pub const va_start = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`"); // /usr/local/zig/lib/compiler/aro/include/stdarg.h:12:9
pub const va_end = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`"); // /usr/local/zig/lib/compiler/aro/include/stdarg.h:14:9
pub const va_arg = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg`"); // /usr/local/zig/lib/compiler/aro/include/stdarg.h:15:9
pub const __va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`"); // /usr/local/zig/lib/compiler/aro/include/stdarg.h:18:9
pub const va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`"); // /usr/local/zig/lib/compiler/aro/include/stdarg.h:22:9
pub const __GNUC_VA_LIST = @as(c_int, 1);
pub const SQLITE_EXTERN = @compileError("unable to translate C expr: unexpected token 'extern'"); // /usr/include/sqlite3.h:72:10
pub const SQLITE_API = "";
pub const SQLITE_CDECL = "";
pub const SQLITE_APICALL = "";
pub const SQLITE_STDCALL = "";
pub const SQLITE_CALLBACK = "";
pub const SQLITE_SYSAPI = "";
pub const SQLITE_DEPRECATED = "";
pub const SQLITE_EXPERIMENTAL = "";
pub const SQLITE_VERSION = "3.50.4";
pub const SQLITE_VERSION_NUMBER = __helpers.promoteIntLiteral(c_int, 3050004, .decimal);
pub const SQLITE_SOURCE_ID = "2025-07-30 19:33:53 4d8adfb30e03f9cf27f800a2c1ba3c48fb4ca1b08b0f5ed59a4d5ecbf45ealt1";
pub const SQLITE_OK = @as(c_int, 0);
pub const SQLITE_ERROR = @as(c_int, 1);
pub const SQLITE_INTERNAL = @as(c_int, 2);
pub const SQLITE_PERM = @as(c_int, 3);
pub const SQLITE_ABORT = @as(c_int, 4);
pub const SQLITE_BUSY = @as(c_int, 5);
pub const SQLITE_LOCKED = @as(c_int, 6);
pub const SQLITE_NOMEM = @as(c_int, 7);
pub const SQLITE_READONLY = @as(c_int, 8);
pub const SQLITE_INTERRUPT = @as(c_int, 9);
pub const SQLITE_IOERR = @as(c_int, 10);
pub const SQLITE_CORRUPT = @as(c_int, 11);
pub const SQLITE_NOTFOUND = @as(c_int, 12);
pub const SQLITE_FULL = @as(c_int, 13);
pub const SQLITE_CANTOPEN = @as(c_int, 14);
pub const SQLITE_PROTOCOL = @as(c_int, 15);
pub const SQLITE_EMPTY = @as(c_int, 16);
pub const SQLITE_SCHEMA = @as(c_int, 17);
pub const SQLITE_TOOBIG = @as(c_int, 18);
pub const SQLITE_CONSTRAINT = @as(c_int, 19);
pub const SQLITE_MISMATCH = @as(c_int, 20);
pub const SQLITE_MISUSE = @as(c_int, 21);
pub const SQLITE_NOLFS = @as(c_int, 22);
pub const SQLITE_AUTH = @as(c_int, 23);
pub const SQLITE_FORMAT = @as(c_int, 24);
pub const SQLITE_RANGE = @as(c_int, 25);
pub const SQLITE_NOTADB = @as(c_int, 26);
pub const SQLITE_NOTICE = @as(c_int, 27);
pub const SQLITE_WARNING = @as(c_int, 28);
pub const SQLITE_ROW = @as(c_int, 100);
pub const SQLITE_DONE = @as(c_int, 101);
pub const SQLITE_ERROR_MISSING_COLLSEQ = SQLITE_ERROR | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_ERROR_RETRY = SQLITE_ERROR | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_ERROR_SNAPSHOT = SQLITE_ERROR | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_IOERR_READ = SQLITE_IOERR | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_IOERR_SHORT_READ = SQLITE_IOERR | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_IOERR_WRITE = SQLITE_IOERR | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_IOERR_FSYNC = SQLITE_IOERR | (@as(c_int, 4) << @as(c_int, 8));
pub const SQLITE_IOERR_DIR_FSYNC = SQLITE_IOERR | (@as(c_int, 5) << @as(c_int, 8));
pub const SQLITE_IOERR_TRUNCATE = SQLITE_IOERR | (@as(c_int, 6) << @as(c_int, 8));
pub const SQLITE_IOERR_FSTAT = SQLITE_IOERR | (@as(c_int, 7) << @as(c_int, 8));
pub const SQLITE_IOERR_UNLOCK = SQLITE_IOERR | (@as(c_int, 8) << @as(c_int, 8));
pub const SQLITE_IOERR_RDLOCK = SQLITE_IOERR | (@as(c_int, 9) << @as(c_int, 8));
pub const SQLITE_IOERR_DELETE = SQLITE_IOERR | (@as(c_int, 10) << @as(c_int, 8));
pub const SQLITE_IOERR_BLOCKED = SQLITE_IOERR | (@as(c_int, 11) << @as(c_int, 8));
pub const SQLITE_IOERR_NOMEM = SQLITE_IOERR | (@as(c_int, 12) << @as(c_int, 8));
pub const SQLITE_IOERR_ACCESS = SQLITE_IOERR | (@as(c_int, 13) << @as(c_int, 8));
pub const SQLITE_IOERR_CHECKRESERVEDLOCK = SQLITE_IOERR | (@as(c_int, 14) << @as(c_int, 8));
pub const SQLITE_IOERR_LOCK = SQLITE_IOERR | (@as(c_int, 15) << @as(c_int, 8));
pub const SQLITE_IOERR_CLOSE = SQLITE_IOERR | (@as(c_int, 16) << @as(c_int, 8));
pub const SQLITE_IOERR_DIR_CLOSE = SQLITE_IOERR | (@as(c_int, 17) << @as(c_int, 8));
pub const SQLITE_IOERR_SHMOPEN = SQLITE_IOERR | (@as(c_int, 18) << @as(c_int, 8));
pub const SQLITE_IOERR_SHMSIZE = SQLITE_IOERR | (@as(c_int, 19) << @as(c_int, 8));
pub const SQLITE_IOERR_SHMLOCK = SQLITE_IOERR | (@as(c_int, 20) << @as(c_int, 8));
pub const SQLITE_IOERR_SHMMAP = SQLITE_IOERR | (@as(c_int, 21) << @as(c_int, 8));
pub const SQLITE_IOERR_SEEK = SQLITE_IOERR | (@as(c_int, 22) << @as(c_int, 8));
pub const SQLITE_IOERR_DELETE_NOENT = SQLITE_IOERR | (@as(c_int, 23) << @as(c_int, 8));
pub const SQLITE_IOERR_MMAP = SQLITE_IOERR | (@as(c_int, 24) << @as(c_int, 8));
pub const SQLITE_IOERR_GETTEMPPATH = SQLITE_IOERR | (@as(c_int, 25) << @as(c_int, 8));
pub const SQLITE_IOERR_CONVPATH = SQLITE_IOERR | (@as(c_int, 26) << @as(c_int, 8));
pub const SQLITE_IOERR_VNODE = SQLITE_IOERR | (@as(c_int, 27) << @as(c_int, 8));
pub const SQLITE_IOERR_AUTH = SQLITE_IOERR | (@as(c_int, 28) << @as(c_int, 8));
pub const SQLITE_IOERR_BEGIN_ATOMIC = SQLITE_IOERR | (@as(c_int, 29) << @as(c_int, 8));
pub const SQLITE_IOERR_COMMIT_ATOMIC = SQLITE_IOERR | (@as(c_int, 30) << @as(c_int, 8));
pub const SQLITE_IOERR_ROLLBACK_ATOMIC = SQLITE_IOERR | (@as(c_int, 31) << @as(c_int, 8));
pub const SQLITE_IOERR_DATA = SQLITE_IOERR | (@as(c_int, 32) << @as(c_int, 8));
pub const SQLITE_IOERR_CORRUPTFS = SQLITE_IOERR | (@as(c_int, 33) << @as(c_int, 8));
pub const SQLITE_IOERR_IN_PAGE = SQLITE_IOERR | (@as(c_int, 34) << @as(c_int, 8));
pub const SQLITE_LOCKED_SHAREDCACHE = SQLITE_LOCKED | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_LOCKED_VTAB = SQLITE_LOCKED | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_BUSY_RECOVERY = SQLITE_BUSY | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_BUSY_SNAPSHOT = SQLITE_BUSY | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_BUSY_TIMEOUT = SQLITE_BUSY | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_CANTOPEN_NOTEMPDIR = SQLITE_CANTOPEN | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_CANTOPEN_ISDIR = SQLITE_CANTOPEN | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_CANTOPEN_FULLPATH = SQLITE_CANTOPEN | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_CANTOPEN_CONVPATH = SQLITE_CANTOPEN | (@as(c_int, 4) << @as(c_int, 8));
pub const SQLITE_CANTOPEN_DIRTYWAL = SQLITE_CANTOPEN | (@as(c_int, 5) << @as(c_int, 8));
pub const SQLITE_CANTOPEN_SYMLINK = SQLITE_CANTOPEN | (@as(c_int, 6) << @as(c_int, 8));
pub const SQLITE_CORRUPT_VTAB = SQLITE_CORRUPT | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_CORRUPT_SEQUENCE = SQLITE_CORRUPT | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_CORRUPT_INDEX = SQLITE_CORRUPT | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_READONLY_RECOVERY = SQLITE_READONLY | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_READONLY_CANTLOCK = SQLITE_READONLY | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_READONLY_ROLLBACK = SQLITE_READONLY | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_READONLY_DBMOVED = SQLITE_READONLY | (@as(c_int, 4) << @as(c_int, 8));
pub const SQLITE_READONLY_CANTINIT = SQLITE_READONLY | (@as(c_int, 5) << @as(c_int, 8));
pub const SQLITE_READONLY_DIRECTORY = SQLITE_READONLY | (@as(c_int, 6) << @as(c_int, 8));
pub const SQLITE_ABORT_ROLLBACK = SQLITE_ABORT | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_CHECK = SQLITE_CONSTRAINT | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_COMMITHOOK = SQLITE_CONSTRAINT | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_FOREIGNKEY = SQLITE_CONSTRAINT | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_FUNCTION = SQLITE_CONSTRAINT | (@as(c_int, 4) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_NOTNULL = SQLITE_CONSTRAINT | (@as(c_int, 5) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_PRIMARYKEY = SQLITE_CONSTRAINT | (@as(c_int, 6) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_TRIGGER = SQLITE_CONSTRAINT | (@as(c_int, 7) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_UNIQUE = SQLITE_CONSTRAINT | (@as(c_int, 8) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_VTAB = SQLITE_CONSTRAINT | (@as(c_int, 9) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_ROWID = SQLITE_CONSTRAINT | (@as(c_int, 10) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_PINNED = SQLITE_CONSTRAINT | (@as(c_int, 11) << @as(c_int, 8));
pub const SQLITE_CONSTRAINT_DATATYPE = SQLITE_CONSTRAINT | (@as(c_int, 12) << @as(c_int, 8));
pub const SQLITE_NOTICE_RECOVER_WAL = SQLITE_NOTICE | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_NOTICE_RECOVER_ROLLBACK = SQLITE_NOTICE | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_NOTICE_RBU = SQLITE_NOTICE | (@as(c_int, 3) << @as(c_int, 8));
pub const SQLITE_WARNING_AUTOINDEX = SQLITE_WARNING | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_AUTH_USER = SQLITE_AUTH | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_OK_LOAD_PERMANENTLY = SQLITE_OK | (@as(c_int, 1) << @as(c_int, 8));
pub const SQLITE_OK_SYMLINK = SQLITE_OK | (@as(c_int, 2) << @as(c_int, 8));
pub const SQLITE_OPEN_READONLY = @as(c_int, 0x00000001);
pub const SQLITE_OPEN_READWRITE = @as(c_int, 0x00000002);
pub const SQLITE_OPEN_CREATE = @as(c_int, 0x00000004);
pub const SQLITE_OPEN_DELETEONCLOSE = @as(c_int, 0x00000008);
pub const SQLITE_OPEN_EXCLUSIVE = @as(c_int, 0x00000010);
pub const SQLITE_OPEN_AUTOPROXY = @as(c_int, 0x00000020);
pub const SQLITE_OPEN_URI = @as(c_int, 0x00000040);
pub const SQLITE_OPEN_MEMORY = @as(c_int, 0x00000080);
pub const SQLITE_OPEN_MAIN_DB = @as(c_int, 0x00000100);
pub const SQLITE_OPEN_TEMP_DB = @as(c_int, 0x00000200);
pub const SQLITE_OPEN_TRANSIENT_DB = @as(c_int, 0x00000400);
pub const SQLITE_OPEN_MAIN_JOURNAL = @as(c_int, 0x00000800);
pub const SQLITE_OPEN_TEMP_JOURNAL = @as(c_int, 0x00001000);
pub const SQLITE_OPEN_SUBJOURNAL = @as(c_int, 0x00002000);
pub const SQLITE_OPEN_SUPER_JOURNAL = @as(c_int, 0x00004000);
pub const SQLITE_OPEN_NOMUTEX = __helpers.promoteIntLiteral(c_int, 0x00008000, .hex);
pub const SQLITE_OPEN_FULLMUTEX = __helpers.promoteIntLiteral(c_int, 0x00010000, .hex);
pub const SQLITE_OPEN_SHAREDCACHE = __helpers.promoteIntLiteral(c_int, 0x00020000, .hex);
pub const SQLITE_OPEN_PRIVATECACHE = __helpers.promoteIntLiteral(c_int, 0x00040000, .hex);
pub const SQLITE_OPEN_WAL = __helpers.promoteIntLiteral(c_int, 0x00080000, .hex);
pub const SQLITE_OPEN_NOFOLLOW = __helpers.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const SQLITE_OPEN_EXRESCODE = __helpers.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const SQLITE_OPEN_MASTER_JOURNAL = @as(c_int, 0x00004000);
pub const SQLITE_IOCAP_ATOMIC = @as(c_int, 0x00000001);
pub const SQLITE_IOCAP_ATOMIC512 = @as(c_int, 0x00000002);
pub const SQLITE_IOCAP_ATOMIC1K = @as(c_int, 0x00000004);
pub const SQLITE_IOCAP_ATOMIC2K = @as(c_int, 0x00000008);
pub const SQLITE_IOCAP_ATOMIC4K = @as(c_int, 0x00000010);
pub const SQLITE_IOCAP_ATOMIC8K = @as(c_int, 0x00000020);
pub const SQLITE_IOCAP_ATOMIC16K = @as(c_int, 0x00000040);
pub const SQLITE_IOCAP_ATOMIC32K = @as(c_int, 0x00000080);
pub const SQLITE_IOCAP_ATOMIC64K = @as(c_int, 0x00000100);
pub const SQLITE_IOCAP_SAFE_APPEND = @as(c_int, 0x00000200);
pub const SQLITE_IOCAP_SEQUENTIAL = @as(c_int, 0x00000400);
pub const SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN = @as(c_int, 0x00000800);
pub const SQLITE_IOCAP_POWERSAFE_OVERWRITE = @as(c_int, 0x00001000);
pub const SQLITE_IOCAP_IMMUTABLE = @as(c_int, 0x00002000);
pub const SQLITE_IOCAP_BATCH_ATOMIC = @as(c_int, 0x00004000);
pub const SQLITE_IOCAP_SUBPAGE_READ = __helpers.promoteIntLiteral(c_int, 0x00008000, .hex);
pub const SQLITE_LOCK_NONE = @as(c_int, 0);
pub const SQLITE_LOCK_SHARED = @as(c_int, 1);
pub const SQLITE_LOCK_RESERVED = @as(c_int, 2);
pub const SQLITE_LOCK_PENDING = @as(c_int, 3);
pub const SQLITE_LOCK_EXCLUSIVE = @as(c_int, 4);
pub const SQLITE_SYNC_NORMAL = @as(c_int, 0x00002);
pub const SQLITE_SYNC_FULL = @as(c_int, 0x00003);
pub const SQLITE_SYNC_DATAONLY = @as(c_int, 0x00010);
pub const SQLITE_FCNTL_LOCKSTATE = @as(c_int, 1);
pub const SQLITE_FCNTL_GET_LOCKPROXYFILE = @as(c_int, 2);
pub const SQLITE_FCNTL_SET_LOCKPROXYFILE = @as(c_int, 3);
pub const SQLITE_FCNTL_LAST_ERRNO = @as(c_int, 4);
pub const SQLITE_FCNTL_SIZE_HINT = @as(c_int, 5);
pub const SQLITE_FCNTL_CHUNK_SIZE = @as(c_int, 6);
pub const SQLITE_FCNTL_FILE_POINTER = @as(c_int, 7);
pub const SQLITE_FCNTL_SYNC_OMITTED = @as(c_int, 8);
pub const SQLITE_FCNTL_WIN32_AV_RETRY = @as(c_int, 9);
pub const SQLITE_FCNTL_PERSIST_WAL = @as(c_int, 10);
pub const SQLITE_FCNTL_OVERWRITE = @as(c_int, 11);
pub const SQLITE_FCNTL_VFSNAME = @as(c_int, 12);
pub const SQLITE_FCNTL_POWERSAFE_OVERWRITE = @as(c_int, 13);
pub const SQLITE_FCNTL_PRAGMA = @as(c_int, 14);
pub const SQLITE_FCNTL_BUSYHANDLER = @as(c_int, 15);
pub const SQLITE_FCNTL_TEMPFILENAME = @as(c_int, 16);
pub const SQLITE_FCNTL_MMAP_SIZE = @as(c_int, 18);
pub const SQLITE_FCNTL_TRACE = @as(c_int, 19);
pub const SQLITE_FCNTL_HAS_MOVED = @as(c_int, 20);
pub const SQLITE_FCNTL_SYNC = @as(c_int, 21);
pub const SQLITE_FCNTL_COMMIT_PHASETWO = @as(c_int, 22);
pub const SQLITE_FCNTL_WIN32_SET_HANDLE = @as(c_int, 23);
pub const SQLITE_FCNTL_WAL_BLOCK = @as(c_int, 24);
pub const SQLITE_FCNTL_ZIPVFS = @as(c_int, 25);
pub const SQLITE_FCNTL_RBU = @as(c_int, 26);
pub const SQLITE_FCNTL_VFS_POINTER = @as(c_int, 27);
pub const SQLITE_FCNTL_JOURNAL_POINTER = @as(c_int, 28);
pub const SQLITE_FCNTL_WIN32_GET_HANDLE = @as(c_int, 29);
pub const SQLITE_FCNTL_PDB = @as(c_int, 30);
pub const SQLITE_FCNTL_BEGIN_ATOMIC_WRITE = @as(c_int, 31);
pub const SQLITE_FCNTL_COMMIT_ATOMIC_WRITE = @as(c_int, 32);
pub const SQLITE_FCNTL_ROLLBACK_ATOMIC_WRITE = @as(c_int, 33);
pub const SQLITE_FCNTL_LOCK_TIMEOUT = @as(c_int, 34);
pub const SQLITE_FCNTL_DATA_VERSION = @as(c_int, 35);
pub const SQLITE_FCNTL_SIZE_LIMIT = @as(c_int, 36);
pub const SQLITE_FCNTL_CKPT_DONE = @as(c_int, 37);
pub const SQLITE_FCNTL_RESERVE_BYTES = @as(c_int, 38);
pub const SQLITE_FCNTL_CKPT_START = @as(c_int, 39);
pub const SQLITE_FCNTL_EXTERNAL_READER = @as(c_int, 40);
pub const SQLITE_FCNTL_CKSM_FILE = @as(c_int, 41);
pub const SQLITE_FCNTL_RESET_CACHE = @as(c_int, 42);
pub const SQLITE_FCNTL_NULL_IO = @as(c_int, 43);
pub const SQLITE_FCNTL_BLOCK_ON_CONNECT = @as(c_int, 44);
pub const SQLITE_GET_LOCKPROXYFILE = SQLITE_FCNTL_GET_LOCKPROXYFILE;
pub const SQLITE_SET_LOCKPROXYFILE = SQLITE_FCNTL_SET_LOCKPROXYFILE;
pub const SQLITE_LAST_ERRNO = SQLITE_FCNTL_LAST_ERRNO;
pub const SQLITE_ACCESS_EXISTS = @as(c_int, 0);
pub const SQLITE_ACCESS_READWRITE = @as(c_int, 1);
pub const SQLITE_ACCESS_READ = @as(c_int, 2);
pub const SQLITE_SHM_UNLOCK = @as(c_int, 1);
pub const SQLITE_SHM_LOCK = @as(c_int, 2);
pub const SQLITE_SHM_SHARED = @as(c_int, 4);
pub const SQLITE_SHM_EXCLUSIVE = @as(c_int, 8);
pub const SQLITE_SHM_NLOCK = @as(c_int, 8);
pub const SQLITE_CONFIG_SINGLETHREAD = @as(c_int, 1);
pub const SQLITE_CONFIG_MULTITHREAD = @as(c_int, 2);
pub const SQLITE_CONFIG_SERIALIZED = @as(c_int, 3);
pub const SQLITE_CONFIG_MALLOC = @as(c_int, 4);
pub const SQLITE_CONFIG_GETMALLOC = @as(c_int, 5);
pub const SQLITE_CONFIG_SCRATCH = @as(c_int, 6);
pub const SQLITE_CONFIG_PAGECACHE = @as(c_int, 7);
pub const SQLITE_CONFIG_HEAP = @as(c_int, 8);
pub const SQLITE_CONFIG_MEMSTATUS = @as(c_int, 9);
pub const SQLITE_CONFIG_MUTEX = @as(c_int, 10);
pub const SQLITE_CONFIG_GETMUTEX = @as(c_int, 11);
pub const SQLITE_CONFIG_LOOKASIDE = @as(c_int, 13);
pub const SQLITE_CONFIG_PCACHE = @as(c_int, 14);
pub const SQLITE_CONFIG_GETPCACHE = @as(c_int, 15);
pub const SQLITE_CONFIG_LOG = @as(c_int, 16);
pub const SQLITE_CONFIG_URI = @as(c_int, 17);
pub const SQLITE_CONFIG_PCACHE2 = @as(c_int, 18);
pub const SQLITE_CONFIG_GETPCACHE2 = @as(c_int, 19);
pub const SQLITE_CONFIG_COVERING_INDEX_SCAN = @as(c_int, 20);
pub const SQLITE_CONFIG_SQLLOG = @as(c_int, 21);
pub const SQLITE_CONFIG_MMAP_SIZE = @as(c_int, 22);
pub const SQLITE_CONFIG_WIN32_HEAPSIZE = @as(c_int, 23);
pub const SQLITE_CONFIG_PCACHE_HDRSZ = @as(c_int, 24);
pub const SQLITE_CONFIG_PMASZ = @as(c_int, 25);
pub const SQLITE_CONFIG_STMTJRNL_SPILL = @as(c_int, 26);
pub const SQLITE_CONFIG_SMALL_MALLOC = @as(c_int, 27);
pub const SQLITE_CONFIG_SORTERREF_SIZE = @as(c_int, 28);
pub const SQLITE_CONFIG_MEMDB_MAXSIZE = @as(c_int, 29);
pub const SQLITE_CONFIG_ROWID_IN_VIEW = @as(c_int, 30);
pub const SQLITE_DBCONFIG_MAINDBNAME = @as(c_int, 1000);
pub const SQLITE_DBCONFIG_LOOKASIDE = @as(c_int, 1001);
pub const SQLITE_DBCONFIG_ENABLE_FKEY = @as(c_int, 1002);
pub const SQLITE_DBCONFIG_ENABLE_TRIGGER = @as(c_int, 1003);
pub const SQLITE_DBCONFIG_ENABLE_FTS3_TOKENIZER = @as(c_int, 1004);
pub const SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION = @as(c_int, 1005);
pub const SQLITE_DBCONFIG_NO_CKPT_ON_CLOSE = @as(c_int, 1006);
pub const SQLITE_DBCONFIG_ENABLE_QPSG = @as(c_int, 1007);
pub const SQLITE_DBCONFIG_TRIGGER_EQP = @as(c_int, 1008);
pub const SQLITE_DBCONFIG_RESET_DATABASE = @as(c_int, 1009);
pub const SQLITE_DBCONFIG_DEFENSIVE = @as(c_int, 1010);
pub const SQLITE_DBCONFIG_WRITABLE_SCHEMA = @as(c_int, 1011);
pub const SQLITE_DBCONFIG_LEGACY_ALTER_TABLE = @as(c_int, 1012);
pub const SQLITE_DBCONFIG_DQS_DML = @as(c_int, 1013);
pub const SQLITE_DBCONFIG_DQS_DDL = @as(c_int, 1014);
pub const SQLITE_DBCONFIG_ENABLE_VIEW = @as(c_int, 1015);
pub const SQLITE_DBCONFIG_LEGACY_FILE_FORMAT = @as(c_int, 1016);
pub const SQLITE_DBCONFIG_TRUSTED_SCHEMA = @as(c_int, 1017);
pub const SQLITE_DBCONFIG_STMT_SCANSTATUS = @as(c_int, 1018);
pub const SQLITE_DBCONFIG_REVERSE_SCANORDER = @as(c_int, 1019);
pub const SQLITE_DBCONFIG_ENABLE_ATTACH_CREATE = @as(c_int, 1020);
pub const SQLITE_DBCONFIG_ENABLE_ATTACH_WRITE = @as(c_int, 1021);
pub const SQLITE_DBCONFIG_ENABLE_COMMENTS = @as(c_int, 1022);
pub const SQLITE_DBCONFIG_MAX = @as(c_int, 1022);
pub const SQLITE_SETLK_BLOCK_ON_CONNECT = @as(c_int, 0x01);
pub const SQLITE_DENY = @as(c_int, 1);
pub const SQLITE_IGNORE = @as(c_int, 2);
pub const SQLITE_CREATE_INDEX = @as(c_int, 1);
pub const SQLITE_CREATE_TABLE = @as(c_int, 2);
pub const SQLITE_CREATE_TEMP_INDEX = @as(c_int, 3);
pub const SQLITE_CREATE_TEMP_TABLE = @as(c_int, 4);
pub const SQLITE_CREATE_TEMP_TRIGGER = @as(c_int, 5);
pub const SQLITE_CREATE_TEMP_VIEW = @as(c_int, 6);
pub const SQLITE_CREATE_TRIGGER = @as(c_int, 7);
pub const SQLITE_CREATE_VIEW = @as(c_int, 8);
pub const SQLITE_DELETE = @as(c_int, 9);
pub const SQLITE_DROP_INDEX = @as(c_int, 10);
pub const SQLITE_DROP_TABLE = @as(c_int, 11);
pub const SQLITE_DROP_TEMP_INDEX = @as(c_int, 12);
pub const SQLITE_DROP_TEMP_TABLE = @as(c_int, 13);
pub const SQLITE_DROP_TEMP_TRIGGER = @as(c_int, 14);
pub const SQLITE_DROP_TEMP_VIEW = @as(c_int, 15);
pub const SQLITE_DROP_TRIGGER = @as(c_int, 16);
pub const SQLITE_DROP_VIEW = @as(c_int, 17);
pub const SQLITE_INSERT = @as(c_int, 18);
pub const SQLITE_PRAGMA = @as(c_int, 19);
pub const SQLITE_READ = @as(c_int, 20);
pub const SQLITE_SELECT = @as(c_int, 21);
pub const SQLITE_TRANSACTION = @as(c_int, 22);
pub const SQLITE_UPDATE = @as(c_int, 23);
pub const SQLITE_ATTACH = @as(c_int, 24);
pub const SQLITE_DETACH = @as(c_int, 25);
pub const SQLITE_ALTER_TABLE = @as(c_int, 26);
pub const SQLITE_REINDEX = @as(c_int, 27);
pub const SQLITE_ANALYZE = @as(c_int, 28);
pub const SQLITE_CREATE_VTABLE = @as(c_int, 29);
pub const SQLITE_DROP_VTABLE = @as(c_int, 30);
pub const SQLITE_FUNCTION = @as(c_int, 31);
pub const SQLITE_SAVEPOINT = @as(c_int, 32);
pub const SQLITE_COPY = @as(c_int, 0);
pub const SQLITE_RECURSIVE = @as(c_int, 33);
pub const SQLITE_TRACE_STMT = @as(c_int, 0x01);
pub const SQLITE_TRACE_PROFILE = @as(c_int, 0x02);
pub const SQLITE_TRACE_ROW = @as(c_int, 0x04);
pub const SQLITE_TRACE_CLOSE = @as(c_int, 0x08);
pub const SQLITE_LIMIT_LENGTH = @as(c_int, 0);
pub const SQLITE_LIMIT_SQL_LENGTH = @as(c_int, 1);
pub const SQLITE_LIMIT_COLUMN = @as(c_int, 2);
pub const SQLITE_LIMIT_EXPR_DEPTH = @as(c_int, 3);
pub const SQLITE_LIMIT_COMPOUND_SELECT = @as(c_int, 4);
pub const SQLITE_LIMIT_VDBE_OP = @as(c_int, 5);
pub const SQLITE_LIMIT_FUNCTION_ARG = @as(c_int, 6);
pub const SQLITE_LIMIT_ATTACHED = @as(c_int, 7);
pub const SQLITE_LIMIT_LIKE_PATTERN_LENGTH = @as(c_int, 8);
pub const SQLITE_LIMIT_VARIABLE_NUMBER = @as(c_int, 9);
pub const SQLITE_LIMIT_TRIGGER_DEPTH = @as(c_int, 10);
pub const SQLITE_LIMIT_WORKER_THREADS = @as(c_int, 11);
pub const SQLITE_PREPARE_PERSISTENT = @as(c_int, 0x01);
pub const SQLITE_PREPARE_NORMALIZE = @as(c_int, 0x02);
pub const SQLITE_PREPARE_NO_VTAB = @as(c_int, 0x04);
pub const SQLITE_PREPARE_DONT_LOG = @as(c_int, 0x10);
pub const SQLITE_INTEGER = @as(c_int, 1);
pub const SQLITE_FLOAT = @as(c_int, 2);
pub const SQLITE_BLOB = @as(c_int, 4);
pub const SQLITE_NULL = @as(c_int, 5);
pub const SQLITE_TEXT = @as(c_int, 3);
pub const SQLITE3_TEXT = @as(c_int, 3);
pub const SQLITE_UTF8 = @as(c_int, 1);
pub const SQLITE_UTF16LE = @as(c_int, 2);
pub const SQLITE_UTF16BE = @as(c_int, 3);
pub const SQLITE_UTF16 = @as(c_int, 4);
pub const SQLITE_ANY = @as(c_int, 5);
pub const SQLITE_UTF16_ALIGNED = @as(c_int, 8);
pub const SQLITE_DETERMINISTIC = @as(c_int, 0x000000800);
pub const SQLITE_DIRECTONLY = __helpers.promoteIntLiteral(c_int, 0x000080000, .hex);
pub const SQLITE_SUBTYPE = __helpers.promoteIntLiteral(c_int, 0x000100000, .hex);
pub const SQLITE_INNOCUOUS = __helpers.promoteIntLiteral(c_int, 0x000200000, .hex);
pub const SQLITE_RESULT_SUBTYPE = __helpers.promoteIntLiteral(c_int, 0x001000000, .hex);
pub const SQLITE_SELFORDER1 = __helpers.promoteIntLiteral(c_int, 0x002000000, .hex);
pub const SQLITE_STATIC = __helpers.cast(sqlite3_destructor_type, @as(c_int, 0));
pub const SQLITE_TRANSIENT = __helpers.cast(sqlite3_destructor_type, -@as(c_int, 1));
pub const SQLITE_WIN32_DATA_DIRECTORY_TYPE = @as(c_int, 1);
pub const SQLITE_WIN32_TEMP_DIRECTORY_TYPE = @as(c_int, 2);
pub const SQLITE_TXN_NONE = @as(c_int, 0);
pub const SQLITE_TXN_READ = @as(c_int, 1);
pub const SQLITE_TXN_WRITE = @as(c_int, 2);
pub const SQLITE_INDEX_SCAN_UNIQUE = @as(c_int, 0x00000001);
pub const SQLITE_INDEX_SCAN_HEX = @as(c_int, 0x00000002);
pub const SQLITE_INDEX_CONSTRAINT_EQ = @as(c_int, 2);
pub const SQLITE_INDEX_CONSTRAINT_GT = @as(c_int, 4);
pub const SQLITE_INDEX_CONSTRAINT_LE = @as(c_int, 8);
pub const SQLITE_INDEX_CONSTRAINT_LT = @as(c_int, 16);
pub const SQLITE_INDEX_CONSTRAINT_GE = @as(c_int, 32);
pub const SQLITE_INDEX_CONSTRAINT_MATCH = @as(c_int, 64);
pub const SQLITE_INDEX_CONSTRAINT_LIKE = @as(c_int, 65);
pub const SQLITE_INDEX_CONSTRAINT_GLOB = @as(c_int, 66);
pub const SQLITE_INDEX_CONSTRAINT_REGEXP = @as(c_int, 67);
pub const SQLITE_INDEX_CONSTRAINT_NE = @as(c_int, 68);
pub const SQLITE_INDEX_CONSTRAINT_ISNOT = @as(c_int, 69);
pub const SQLITE_INDEX_CONSTRAINT_ISNOTNULL = @as(c_int, 70);
pub const SQLITE_INDEX_CONSTRAINT_ISNULL = @as(c_int, 71);
pub const SQLITE_INDEX_CONSTRAINT_IS = @as(c_int, 72);
pub const SQLITE_INDEX_CONSTRAINT_LIMIT = @as(c_int, 73);
pub const SQLITE_INDEX_CONSTRAINT_OFFSET = @as(c_int, 74);
pub const SQLITE_INDEX_CONSTRAINT_FUNCTION = @as(c_int, 150);
pub const SQLITE_MUTEX_FAST = @as(c_int, 0);
pub const SQLITE_MUTEX_RECURSIVE = @as(c_int, 1);
pub const SQLITE_MUTEX_STATIC_MAIN = @as(c_int, 2);
pub const SQLITE_MUTEX_STATIC_MEM = @as(c_int, 3);
pub const SQLITE_MUTEX_STATIC_MEM2 = @as(c_int, 4);
pub const SQLITE_MUTEX_STATIC_OPEN = @as(c_int, 4);
pub const SQLITE_MUTEX_STATIC_PRNG = @as(c_int, 5);
pub const SQLITE_MUTEX_STATIC_LRU = @as(c_int, 6);
pub const SQLITE_MUTEX_STATIC_LRU2 = @as(c_int, 7);
pub const SQLITE_MUTEX_STATIC_PMEM = @as(c_int, 7);
pub const SQLITE_MUTEX_STATIC_APP1 = @as(c_int, 8);
pub const SQLITE_MUTEX_STATIC_APP2 = @as(c_int, 9);
pub const SQLITE_MUTEX_STATIC_APP3 = @as(c_int, 10);
pub const SQLITE_MUTEX_STATIC_VFS1 = @as(c_int, 11);
pub const SQLITE_MUTEX_STATIC_VFS2 = @as(c_int, 12);
pub const SQLITE_MUTEX_STATIC_VFS3 = @as(c_int, 13);
pub const SQLITE_MUTEX_STATIC_MASTER = @as(c_int, 2);
pub const SQLITE_TESTCTRL_FIRST = @as(c_int, 5);
pub const SQLITE_TESTCTRL_PRNG_SAVE = @as(c_int, 5);
pub const SQLITE_TESTCTRL_PRNG_RESTORE = @as(c_int, 6);
pub const SQLITE_TESTCTRL_PRNG_RESET = @as(c_int, 7);
pub const SQLITE_TESTCTRL_FK_NO_ACTION = @as(c_int, 7);
pub const SQLITE_TESTCTRL_BITVEC_TEST = @as(c_int, 8);
pub const SQLITE_TESTCTRL_FAULT_INSTALL = @as(c_int, 9);
pub const SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = @as(c_int, 10);
pub const SQLITE_TESTCTRL_PENDING_BYTE = @as(c_int, 11);
pub const SQLITE_TESTCTRL_ASSERT = @as(c_int, 12);
pub const SQLITE_TESTCTRL_ALWAYS = @as(c_int, 13);
pub const SQLITE_TESTCTRL_RESERVE = @as(c_int, 14);
pub const SQLITE_TESTCTRL_JSON_SELFCHECK = @as(c_int, 14);
pub const SQLITE_TESTCTRL_OPTIMIZATIONS = @as(c_int, 15);
pub const SQLITE_TESTCTRL_ISKEYWORD = @as(c_int, 16);
pub const SQLITE_TESTCTRL_GETOPT = @as(c_int, 16);
pub const SQLITE_TESTCTRL_SCRATCHMALLOC = @as(c_int, 17);
pub const SQLITE_TESTCTRL_INTERNAL_FUNCTIONS = @as(c_int, 17);
pub const SQLITE_TESTCTRL_LOCALTIME_FAULT = @as(c_int, 18);
pub const SQLITE_TESTCTRL_EXPLAIN_STMT = @as(c_int, 19);
pub const SQLITE_TESTCTRL_ONCE_RESET_THRESHOLD = @as(c_int, 19);
pub const SQLITE_TESTCTRL_NEVER_CORRUPT = @as(c_int, 20);
pub const SQLITE_TESTCTRL_VDBE_COVERAGE = @as(c_int, 21);
pub const SQLITE_TESTCTRL_BYTEORDER = @as(c_int, 22);
pub const SQLITE_TESTCTRL_ISINIT = @as(c_int, 23);
pub const SQLITE_TESTCTRL_SORTER_MMAP = @as(c_int, 24);
pub const SQLITE_TESTCTRL_IMPOSTER = @as(c_int, 25);
pub const SQLITE_TESTCTRL_PARSER_COVERAGE = @as(c_int, 26);
pub const SQLITE_TESTCTRL_RESULT_INTREAL = @as(c_int, 27);
pub const SQLITE_TESTCTRL_PRNG_SEED = @as(c_int, 28);
pub const SQLITE_TESTCTRL_EXTRA_SCHEMA_CHECKS = @as(c_int, 29);
pub const SQLITE_TESTCTRL_SEEK_COUNT = @as(c_int, 30);
pub const SQLITE_TESTCTRL_TRACEFLAGS = @as(c_int, 31);
pub const SQLITE_TESTCTRL_TUNE = @as(c_int, 32);
pub const SQLITE_TESTCTRL_LOGEST = @as(c_int, 33);
pub const SQLITE_TESTCTRL_USELONGDOUBLE = @as(c_int, 34);
pub const SQLITE_TESTCTRL_LAST = @as(c_int, 34);
pub const SQLITE_STATUS_MEMORY_USED = @as(c_int, 0);
pub const SQLITE_STATUS_PAGECACHE_USED = @as(c_int, 1);
pub const SQLITE_STATUS_PAGECACHE_OVERFLOW = @as(c_int, 2);
pub const SQLITE_STATUS_SCRATCH_USED = @as(c_int, 3);
pub const SQLITE_STATUS_SCRATCH_OVERFLOW = @as(c_int, 4);
pub const SQLITE_STATUS_MALLOC_SIZE = @as(c_int, 5);
pub const SQLITE_STATUS_PARSER_STACK = @as(c_int, 6);
pub const SQLITE_STATUS_PAGECACHE_SIZE = @as(c_int, 7);
pub const SQLITE_STATUS_SCRATCH_SIZE = @as(c_int, 8);
pub const SQLITE_STATUS_MALLOC_COUNT = @as(c_int, 9);
pub const SQLITE_DBSTATUS_LOOKASIDE_USED = @as(c_int, 0);
pub const SQLITE_DBSTATUS_CACHE_USED = @as(c_int, 1);
pub const SQLITE_DBSTATUS_SCHEMA_USED = @as(c_int, 2);
pub const SQLITE_DBSTATUS_STMT_USED = @as(c_int, 3);
pub const SQLITE_DBSTATUS_LOOKASIDE_HIT = @as(c_int, 4);
pub const SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE = @as(c_int, 5);
pub const SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL = @as(c_int, 6);
pub const SQLITE_DBSTATUS_CACHE_HIT = @as(c_int, 7);
pub const SQLITE_DBSTATUS_CACHE_MISS = @as(c_int, 8);
pub const SQLITE_DBSTATUS_CACHE_WRITE = @as(c_int, 9);
pub const SQLITE_DBSTATUS_DEFERRED_FKS = @as(c_int, 10);
pub const SQLITE_DBSTATUS_CACHE_USED_SHARED = @as(c_int, 11);
pub const SQLITE_DBSTATUS_CACHE_SPILL = @as(c_int, 12);
pub const SQLITE_DBSTATUS_MAX = @as(c_int, 12);
pub const SQLITE_STMTSTATUS_FULLSCAN_STEP = @as(c_int, 1);
pub const SQLITE_STMTSTATUS_SORT = @as(c_int, 2);
pub const SQLITE_STMTSTATUS_AUTOINDEX = @as(c_int, 3);
pub const SQLITE_STMTSTATUS_VM_STEP = @as(c_int, 4);
pub const SQLITE_STMTSTATUS_REPREPARE = @as(c_int, 5);
pub const SQLITE_STMTSTATUS_RUN = @as(c_int, 6);
pub const SQLITE_STMTSTATUS_FILTER_MISS = @as(c_int, 7);
pub const SQLITE_STMTSTATUS_FILTER_HIT = @as(c_int, 8);
pub const SQLITE_STMTSTATUS_MEMUSED = @as(c_int, 99);
pub const SQLITE_CHECKPOINT_PASSIVE = @as(c_int, 0);
pub const SQLITE_CHECKPOINT_FULL = @as(c_int, 1);
pub const SQLITE_CHECKPOINT_RESTART = @as(c_int, 2);
pub const SQLITE_CHECKPOINT_TRUNCATE = @as(c_int, 3);
pub const SQLITE_VTAB_CONSTRAINT_SUPPORT = @as(c_int, 1);
pub const SQLITE_VTAB_INNOCUOUS = @as(c_int, 2);
pub const SQLITE_VTAB_DIRECTONLY = @as(c_int, 3);
pub const SQLITE_VTAB_USES_ALL_SCHEMAS = @as(c_int, 4);
pub const SQLITE_ROLLBACK = @as(c_int, 1);
pub const SQLITE_FAIL = @as(c_int, 3);
pub const SQLITE_REPLACE = @as(c_int, 5);
pub const SQLITE_SCANSTAT_NLOOP = @as(c_int, 0);
pub const SQLITE_SCANSTAT_NVISIT = @as(c_int, 1);
pub const SQLITE_SCANSTAT_EST = @as(c_int, 2);
pub const SQLITE_SCANSTAT_NAME = @as(c_int, 3);
pub const SQLITE_SCANSTAT_EXPLAIN = @as(c_int, 4);
pub const SQLITE_SCANSTAT_SELECTID = @as(c_int, 5);
pub const SQLITE_SCANSTAT_PARENTID = @as(c_int, 6);
pub const SQLITE_SCANSTAT_NCYCLE = @as(c_int, 7);
pub const SQLITE_SCANSTAT_COMPLEX = @as(c_int, 0x0001);
pub const SQLITE_SERIALIZE_NOCOPY = @as(c_int, 0x001);
pub const SQLITE_DESERIALIZE_FREEONCLOSE = @as(c_int, 1);
pub const SQLITE_DESERIALIZE_RESIZEABLE = @as(c_int, 2);
pub const SQLITE_DESERIALIZE_READONLY = @as(c_int, 4);
pub const _SQLITE3RTREE_H_ = "";
pub const NOT_WITHIN = @as(c_int, 0);
pub const PARTLY_WITHIN = @as(c_int, 1);
pub const FULLY_WITHIN = @as(c_int, 2);
pub const _FTS5_H = "";
pub const FTS5_TOKENIZE_QUERY = @as(c_int, 0x0001);
pub const FTS5_TOKENIZE_PREFIX = @as(c_int, 0x0002);
pub const FTS5_TOKENIZE_DOCUMENT = @as(c_int, 0x0004);
pub const FTS5_TOKENIZE_AUX = @as(c_int, 0x0008);
pub const FTS5_TOKEN_COLOCATED = @as(c_int, 0x0001);
pub const _SYS_INOTIFY_H = @as(c_int, 1);
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &maj;
    _ = &min;
    return @as(c_int, 0);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`"); // /usr/include/features.h:191:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2Y = @as(c_int, 0);
pub const __GLIBC_USE_ISOC23 = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_TIME_BITS64 = @as(c_int, 1);
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const __GLIBC_USE_C23_STRTOL = @as(c_int, 0);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`"); // /usr/include/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__builtin.has_builtin(name)) {
    _ = &name;
    return __builtin.has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`"); // /usr/include/sys/cdefs.h:55:10
pub const __LEAF = @compileError("unable to translate macro: undefined identifier `__leaf__`"); // /usr/include/sys/cdefs.h:65:11
pub const __LEAF_ATTR = @compileError("unable to translate macro: undefined identifier `__leaf__`"); // /usr/include/sys/cdefs.h:66:11
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`"); // /usr/include/sys/cdefs.h:82:11
pub const __COLD = @compileError("unable to translate macro: undefined identifier `__cold__`"); // /usr/include/sys/cdefs.h:102:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'"); // /usr/include/sys/cdefs.h:131:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:132:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub const __attribute_overloadable__ = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin.object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin.object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate macro: undefined identifier `__warning__`"); // /usr/include/sys/cdefs.h:366:10
pub const __errordecl = @compileError("unable to translate macro: undefined identifier `__error__`"); // /usr/include/sys/cdefs.h:367:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['"); // /usr/include/sys/cdefs.h:379:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:410:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:417:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:419:11
pub const __ASMNAME = @compileError("unable to translate macro: undefined identifier `__USER_LABEL_PREFIX__`"); // /usr/include/sys/cdefs.h:422:10
pub const __ASMNAME2 = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:423:10
pub const __REDIRECT_FORTIFY = __REDIRECT;
pub const __REDIRECT_FORTIFY_NTH = __REDIRECT_NTH;
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`"); // /usr/include/sys/cdefs.h:452:10
pub const __attribute_alloc_size__ = @compileError("unable to translate macro: undefined identifier `__alloc_size__`"); // /usr/include/sys/cdefs.h:460:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`"); // /usr/include/sys/cdefs.h:469:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`"); // /usr/include/sys/cdefs.h:479:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'"); // /usr/include/sys/cdefs.h:486:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`"); // /usr/include/sys/cdefs.h:492:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`"); // /usr/include/sys/cdefs.h:501:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`"); // /usr/include/sys/cdefs.h:502:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /usr/include/sys/cdefs.h:510:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /usr/include/sys/cdefs.h:520:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`"); // /usr/include/sys/cdefs.h:533:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`"); // /usr/include/sys/cdefs.h:543:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`"); // /usr/include/sys/cdefs.h:555:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`"); // /usr/include/sys/cdefs.h:568:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`"); // /usr/include/sys/cdefs.h:577:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`"); // /usr/include/sys/cdefs.h:595:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`"); // /usr/include/sys/cdefs.h:604:10
pub const __extern_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /usr/include/sys/cdefs.h:626:11
pub const __extern_always_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /usr/include/sys/cdefs.h:627:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __va_arg_pack = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack`"); // /usr/include/sys/cdefs.h:638:10
pub const __va_arg_pack_len = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack_len`"); // /usr/include/sys/cdefs.h:639:10
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'"); // /usr/include/sys/cdefs.h:666:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub const __attribute_copy__ = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:715:10
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub const __LDBL_REDIR1 = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:788:10
pub const __LDBL_REDIR = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:789:10
pub const __LDBL_REDIR1_NTH = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:790:10
pub const __LDBL_REDIR_NTH = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:791:10
pub const __LDBL_REDIR2_DECL = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:792:10
pub const __LDBL_REDIR_DECL = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:793:10
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /usr/include/sys/cdefs.h:807:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`"); // /usr/include/sys/cdefs.h:808:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub const __fortified_attr_access = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:853:11
pub const __attr_access = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:854:11
pub const __attr_access_none = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:855:11
pub const __attr_dealloc = @compileError("unable to translate C expr: unexpected token ''"); // /usr/include/sys/cdefs.h:865:10
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`"); // /usr/include/sys/cdefs.h:872:10
pub const __attribute_struct_may_alias__ = @compileError("unable to translate macro: undefined identifier `__may_alias__`"); // /usr/include/sys/cdefs.h:881:10
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C23 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C23 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 0);
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`"); // /usr/include/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const _BITS_STDINT_LEAST_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const __INT64_C = __helpers.L_SUFFIX;
pub const __UINT64_C = __helpers.UL_SUFFIX;
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = __helpers.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = __helpers.U_SUFFIX;
pub const UINT64_C = __helpers.UL_SUFFIX;
pub const INTMAX_C = __helpers.L_SUFFIX;
pub const UINTMAX_C = __helpers.UL_SUFFIX;
pub const IN_ACCESS = @as(c_int, 0x00000001);
pub const IN_MODIFY = @as(c_int, 0x00000002);
pub const IN_ATTRIB = @as(c_int, 0x00000004);
pub const IN_CLOSE_WRITE = @as(c_int, 0x00000008);
pub const IN_CLOSE_NOWRITE = @as(c_int, 0x00000010);
pub const IN_CLOSE = IN_CLOSE_WRITE | IN_CLOSE_NOWRITE;
pub const IN_OPEN = @as(c_int, 0x00000020);
pub const IN_MOVED_FROM = @as(c_int, 0x00000040);
pub const IN_MOVED_TO = @as(c_int, 0x00000080);
pub const IN_MOVE = IN_MOVED_FROM | IN_MOVED_TO;
pub const IN_CREATE = @as(c_int, 0x00000100);
pub const IN_DELETE = @as(c_int, 0x00000200);
pub const IN_DELETE_SELF = @as(c_int, 0x00000400);
pub const IN_MOVE_SELF = @as(c_int, 0x00000800);
pub const IN_UNMOUNT = @as(c_int, 0x00002000);
pub const IN_Q_OVERFLOW = @as(c_int, 0x00004000);
pub const IN_IGNORED = __helpers.promoteIntLiteral(c_int, 0x00008000, .hex);
pub const IN_ONLYDIR = __helpers.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const IN_DONT_FOLLOW = __helpers.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const IN_EXCL_UNLINK = __helpers.promoteIntLiteral(c_int, 0x04000000, .hex);
pub const IN_MASK_CREATE = __helpers.promoteIntLiteral(c_int, 0x10000000, .hex);
pub const IN_MASK_ADD = __helpers.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const IN_ISDIR = __helpers.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const IN_ONESHOT = __helpers.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const IN_ALL_EVENTS = ((((((((((IN_ACCESS | IN_MODIFY) | IN_ATTRIB) | IN_CLOSE_WRITE) | IN_CLOSE_NOWRITE) | IN_OPEN) | IN_MOVED_FROM) | IN_MOVED_TO) | IN_CREATE) | IN_DELETE) | IN_DELETE_SELF) | IN_MOVE_SELF;
pub const DBUS_H = "";
pub const DBUS_ARCH_DEPS_H = "";
pub const DBUS_MACROS_H = "";
pub const DBUS_BEGIN_DECLS = "";
pub const DBUS_END_DECLS = "";
pub const TRUE = @as(c_int, 1);
pub const FALSE = @as(c_int, 0);
pub const NULL = __helpers.cast(?*anyopaque, @as(c_int, 0));
pub const DBUS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:56:11
pub const _DBUS_GNUC_EXTENSION = @compileError("unable to translate C expr: unexpected token '__extension__'"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:64:11
pub const _DBUS_GNUC_PRINTF = @compileError("unable to translate macro: undefined identifier `__format__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:71:9
pub const _DBUS_GNUC_NORETURN = @compileError("unable to translate macro: undefined identifier `__noreturn__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:73:9
pub const _DBUS_GNUC_UNUSED = @compileError("unable to translate macro: undefined identifier `__unused__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:75:9
pub const DBUS_MALLOC = @compileError("unable to translate macro: undefined identifier `__malloc__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:84:9
pub const DBUS_ALLOC_SIZE = @compileError("unable to translate macro: undefined identifier `__alloc_size__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:90:9
pub const DBUS_ALLOC_SIZE2 = @compileError("unable to translate macro: undefined identifier `__alloc_size__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:91:9
pub const _DBUS_WARN_UNUSED_RESULT = @compileError("unable to translate macro: undefined identifier `warn_unused_result`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:112:9
pub const DBUS_EXPORT = @compileError("unable to translate macro: undefined identifier `__visibility__`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:210:11
pub const _dbus_clear_pointer_impl = @compileError("unable to translate macro: undefined identifier `_pp`"); // /usr/include/dbus-1.0/dbus/dbus-macros.h:223:9
pub const DBUS_HAVE_INT64 = @as(c_int, 1);
pub const DBUS_INT64_MODIFIER = "l";
pub const DBUS_INT64_CONSTANT = @compileError("unable to translate macro: undefined identifier `L`"); // /usr/lib/dbus-1.0/include/dbus/dbus-arch-deps.h:41:9
pub const DBUS_UINT64_CONSTANT = @compileError("unable to translate macro: undefined identifier `UL`"); // /usr/lib/dbus-1.0/include/dbus/dbus-arch-deps.h:42:9
pub const DBUS_SIZEOF_VOID_P = @as(c_int, 8);
pub const DBUS_MAJOR_VERSION = @as(c_int, 1);
pub const DBUS_MINOR_VERSION = @as(c_int, 16);
pub const DBUS_MICRO_VERSION = @as(c_int, 2);
pub const DBUS_VERSION_STRING = "1.16.2";
pub const DBUS_VERSION = ((@as(c_int, 1) << @as(c_int, 16)) | (@as(c_int, 16) << @as(c_int, 8))) | @as(c_int, 2);
pub const DBUS_ADDRESS_H = "";
pub const DBUS_TYPES_H = "";
pub const __STDC_VERSION_STDDEF_H__ = @as(c_long, 202311);
pub const offsetof = @compileError("unable to translate macro: undefined identifier `__builtin_offsetof`"); // /usr/local/zig/lib/compiler/aro/include/stddef.h:18:9
pub const DBUS_ERROR_H = "";
pub const DBUS_PROTOCOL_H = "";
pub const DBUS_LITTLE_ENDIAN = 'l';
pub const DBUS_BIG_ENDIAN = 'B';
pub const DBUS_MAJOR_PROTOCOL_VERSION = @as(c_int, 1);
pub const DBUS_TYPE_INVALID = __helpers.cast(c_int, '\x00');
pub const DBUS_TYPE_INVALID_AS_STRING = "\x00";
pub const DBUS_TYPE_BYTE = __helpers.cast(c_int, 'y');
pub const DBUS_TYPE_BYTE_AS_STRING = "y";
pub const DBUS_TYPE_BOOLEAN = __helpers.cast(c_int, 'b');
pub const DBUS_TYPE_BOOLEAN_AS_STRING = "b";
pub const DBUS_TYPE_INT16 = __helpers.cast(c_int, 'n');
pub const DBUS_TYPE_INT16_AS_STRING = "n";
pub const DBUS_TYPE_UINT16 = __helpers.cast(c_int, 'q');
pub const DBUS_TYPE_UINT16_AS_STRING = "q";
pub const DBUS_TYPE_INT32 = __helpers.cast(c_int, 'i');
pub const DBUS_TYPE_INT32_AS_STRING = "i";
pub const DBUS_TYPE_UINT32 = __helpers.cast(c_int, 'u');
pub const DBUS_TYPE_UINT32_AS_STRING = "u";
pub const DBUS_TYPE_INT64 = __helpers.cast(c_int, 'x');
pub const DBUS_TYPE_INT64_AS_STRING = "x";
pub const DBUS_TYPE_UINT64 = __helpers.cast(c_int, 't');
pub const DBUS_TYPE_UINT64_AS_STRING = "t";
pub const DBUS_TYPE_DOUBLE = __helpers.cast(c_int, 'd');
pub const DBUS_TYPE_DOUBLE_AS_STRING = "d";
pub const DBUS_TYPE_STRING = __helpers.cast(c_int, 's');
pub const DBUS_TYPE_STRING_AS_STRING = "s";
pub const DBUS_TYPE_OBJECT_PATH = __helpers.cast(c_int, 'o');
pub const DBUS_TYPE_OBJECT_PATH_AS_STRING = "o";
pub const DBUS_TYPE_SIGNATURE = __helpers.cast(c_int, 'g');
pub const DBUS_TYPE_SIGNATURE_AS_STRING = "g";
pub const DBUS_TYPE_UNIX_FD = __helpers.cast(c_int, 'h');
pub const DBUS_TYPE_UNIX_FD_AS_STRING = "h";
pub const DBUS_TYPE_ARRAY = __helpers.cast(c_int, 'a');
pub const DBUS_TYPE_ARRAY_AS_STRING = "a";
pub const DBUS_TYPE_VARIANT = __helpers.cast(c_int, 'v');
pub const DBUS_TYPE_VARIANT_AS_STRING = "v";
pub const DBUS_TYPE_STRUCT = __helpers.cast(c_int, 'r');
pub const DBUS_TYPE_STRUCT_AS_STRING = "r";
pub const DBUS_TYPE_DICT_ENTRY = __helpers.cast(c_int, 'e');
pub const DBUS_TYPE_DICT_ENTRY_AS_STRING = "e";
pub const DBUS_NUMBER_OF_TYPES = @as(c_int, 16);
pub const DBUS_STRUCT_BEGIN_CHAR = __helpers.cast(c_int, '(');
pub const DBUS_STRUCT_BEGIN_CHAR_AS_STRING = "(";
pub const DBUS_STRUCT_END_CHAR = __helpers.cast(c_int, ')');
pub const DBUS_STRUCT_END_CHAR_AS_STRING = ")";
pub const DBUS_DICT_ENTRY_BEGIN_CHAR = __helpers.cast(c_int, '{');
pub const DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING = "{";
pub const DBUS_DICT_ENTRY_END_CHAR = __helpers.cast(c_int, '}');
pub const DBUS_DICT_ENTRY_END_CHAR_AS_STRING = "}";
pub const DBUS_MAXIMUM_NAME_LENGTH = @as(c_int, 255);
pub const DBUS_MAXIMUM_SIGNATURE_LENGTH = @as(c_int, 255);
pub const DBUS_MAXIMUM_MATCH_RULE_LENGTH = @as(c_int, 1024);
pub const DBUS_MAXIMUM_MATCH_RULE_ARG_NUMBER = @as(c_int, 63);
pub const DBUS_MAXIMUM_ARRAY_LENGTH = __helpers.promoteIntLiteral(c_int, 67108864, .decimal);
pub const DBUS_MAXIMUM_ARRAY_LENGTH_BITS = @as(c_int, 26);
pub const DBUS_MAXIMUM_MESSAGE_LENGTH = DBUS_MAXIMUM_ARRAY_LENGTH * @as(c_int, 2);
pub const DBUS_MAXIMUM_MESSAGE_LENGTH_BITS = @as(c_int, 27);
pub const DBUS_MAXIMUM_MESSAGE_UNIX_FDS = __helpers.div(DBUS_MAXIMUM_MESSAGE_LENGTH, @as(c_int, 4));
pub const DBUS_MAXIMUM_MESSAGE_UNIX_FDS_BITS = DBUS_MAXIMUM_MESSAGE_LENGTH_BITS - @as(c_int, 2);
pub const DBUS_MAXIMUM_TYPE_RECURSION_DEPTH = @as(c_int, 32);
pub const DBUS_MESSAGE_TYPE_INVALID = @as(c_int, 0);
pub const DBUS_MESSAGE_TYPE_METHOD_CALL = @as(c_int, 1);
pub const DBUS_MESSAGE_TYPE_METHOD_RETURN = @as(c_int, 2);
pub const DBUS_MESSAGE_TYPE_ERROR = @as(c_int, 3);
pub const DBUS_MESSAGE_TYPE_SIGNAL = @as(c_int, 4);
pub const DBUS_NUM_MESSAGE_TYPES = @as(c_int, 5);
pub const DBUS_HEADER_FLAG_NO_REPLY_EXPECTED = @as(c_int, 0x1);
pub const DBUS_HEADER_FLAG_NO_AUTO_START = @as(c_int, 0x2);
pub const DBUS_HEADER_FLAG_ALLOW_INTERACTIVE_AUTHORIZATION = @as(c_int, 0x4);
pub const DBUS_HEADER_FIELD_INVALID = @as(c_int, 0);
pub const DBUS_HEADER_FIELD_PATH = @as(c_int, 1);
pub const DBUS_HEADER_FIELD_INTERFACE = @as(c_int, 2);
pub const DBUS_HEADER_FIELD_MEMBER = @as(c_int, 3);
pub const DBUS_HEADER_FIELD_ERROR_NAME = @as(c_int, 4);
pub const DBUS_HEADER_FIELD_REPLY_SERIAL = @as(c_int, 5);
pub const DBUS_HEADER_FIELD_DESTINATION = @as(c_int, 6);
pub const DBUS_HEADER_FIELD_SENDER = @as(c_int, 7);
pub const DBUS_HEADER_FIELD_SIGNATURE = @as(c_int, 8);
pub const DBUS_HEADER_FIELD_UNIX_FDS = @as(c_int, 9);
pub const DBUS_HEADER_FIELD_CONTAINER_INSTANCE = @as(c_int, 10);
pub const DBUS_HEADER_FIELD_LAST = DBUS_HEADER_FIELD_CONTAINER_INSTANCE;
pub const DBUS_HEADER_SIGNATURE = DBUS_TYPE_BYTE_AS_STRING ++ DBUS_TYPE_BYTE_AS_STRING ++ DBUS_TYPE_BYTE_AS_STRING ++ DBUS_TYPE_BYTE_AS_STRING ++ DBUS_TYPE_UINT32_AS_STRING ++ DBUS_TYPE_UINT32_AS_STRING ++ DBUS_TYPE_ARRAY_AS_STRING ++ DBUS_STRUCT_BEGIN_CHAR_AS_STRING ++ DBUS_TYPE_BYTE_AS_STRING ++ DBUS_TYPE_VARIANT_AS_STRING ++ DBUS_STRUCT_END_CHAR_AS_STRING;
pub const DBUS_MINIMUM_HEADER_SIZE = @as(c_int, 16);
pub const DBUS_ERROR_FAILED = "org.freedesktop.DBus.Error.Failed";
pub const DBUS_ERROR_NO_MEMORY = "org.freedesktop.DBus.Error.NoMemory";
pub const DBUS_ERROR_SERVICE_UNKNOWN = "org.freedesktop.DBus.Error.ServiceUnknown";
pub const DBUS_ERROR_NAME_HAS_NO_OWNER = "org.freedesktop.DBus.Error.NameHasNoOwner";
pub const DBUS_ERROR_NO_REPLY = "org.freedesktop.DBus.Error.NoReply";
pub const DBUS_ERROR_IO_ERROR = "org.freedesktop.DBus.Error.IOError";
pub const DBUS_ERROR_BAD_ADDRESS = "org.freedesktop.DBus.Error.BadAddress";
pub const DBUS_ERROR_NOT_SUPPORTED = "org.freedesktop.DBus.Error.NotSupported";
pub const DBUS_ERROR_LIMITS_EXCEEDED = "org.freedesktop.DBus.Error.LimitsExceeded";
pub const DBUS_ERROR_ACCESS_DENIED = "org.freedesktop.DBus.Error.AccessDenied";
pub const DBUS_ERROR_AUTH_FAILED = "org.freedesktop.DBus.Error.AuthFailed";
pub const DBUS_ERROR_NO_SERVER = "org.freedesktop.DBus.Error.NoServer";
pub const DBUS_ERROR_TIMEOUT = "org.freedesktop.DBus.Error.Timeout";
pub const DBUS_ERROR_NO_NETWORK = "org.freedesktop.DBus.Error.NoNetwork";
pub const DBUS_ERROR_ADDRESS_IN_USE = "org.freedesktop.DBus.Error.AddressInUse";
pub const DBUS_ERROR_DISCONNECTED = "org.freedesktop.DBus.Error.Disconnected";
pub const DBUS_ERROR_INVALID_ARGS = "org.freedesktop.DBus.Error.InvalidArgs";
pub const DBUS_ERROR_FILE_NOT_FOUND = "org.freedesktop.DBus.Error.FileNotFound";
pub const DBUS_ERROR_FILE_EXISTS = "org.freedesktop.DBus.Error.FileExists";
pub const DBUS_ERROR_UNKNOWN_METHOD = "org.freedesktop.DBus.Error.UnknownMethod";
pub const DBUS_ERROR_UNKNOWN_OBJECT = "org.freedesktop.DBus.Error.UnknownObject";
pub const DBUS_ERROR_UNKNOWN_INTERFACE = "org.freedesktop.DBus.Error.UnknownInterface";
pub const DBUS_ERROR_UNKNOWN_PROPERTY = "org.freedesktop.DBus.Error.UnknownProperty";
pub const DBUS_ERROR_PROPERTY_READ_ONLY = "org.freedesktop.DBus.Error.PropertyReadOnly";
pub const DBUS_ERROR_TIMED_OUT = "org.freedesktop.DBus.Error.TimedOut";
pub const DBUS_ERROR_MATCH_RULE_NOT_FOUND = "org.freedesktop.DBus.Error.MatchRuleNotFound";
pub const DBUS_ERROR_MATCH_RULE_INVALID = "org.freedesktop.DBus.Error.MatchRuleInvalid";
pub const DBUS_ERROR_SPAWN_EXEC_FAILED = "org.freedesktop.DBus.Error.Spawn.ExecFailed";
pub const DBUS_ERROR_SPAWN_FORK_FAILED = "org.freedesktop.DBus.Error.Spawn.ForkFailed";
pub const DBUS_ERROR_SPAWN_CHILD_EXITED = "org.freedesktop.DBus.Error.Spawn.ChildExited";
pub const DBUS_ERROR_SPAWN_CHILD_SIGNALED = "org.freedesktop.DBus.Error.Spawn.ChildSignaled";
pub const DBUS_ERROR_SPAWN_FAILED = "org.freedesktop.DBus.Error.Spawn.Failed";
pub const DBUS_ERROR_SPAWN_SETUP_FAILED = "org.freedesktop.DBus.Error.Spawn.FailedToSetup";
pub const DBUS_ERROR_SPAWN_CONFIG_INVALID = "org.freedesktop.DBus.Error.Spawn.ConfigInvalid";
pub const DBUS_ERROR_SPAWN_SERVICE_INVALID = "org.freedesktop.DBus.Error.Spawn.ServiceNotValid";
pub const DBUS_ERROR_SPAWN_SERVICE_NOT_FOUND = "org.freedesktop.DBus.Error.Spawn.ServiceNotFound";
pub const DBUS_ERROR_SPAWN_PERMISSIONS_INVALID = "org.freedesktop.DBus.Error.Spawn.PermissionsInvalid";
pub const DBUS_ERROR_SPAWN_FILE_INVALID = "org.freedesktop.DBus.Error.Spawn.FileInvalid";
pub const DBUS_ERROR_SPAWN_NO_MEMORY = "org.freedesktop.DBus.Error.Spawn.NoMemory";
pub const DBUS_ERROR_UNIX_PROCESS_ID_UNKNOWN = "org.freedesktop.DBus.Error.UnixProcessIdUnknown";
pub const DBUS_ERROR_INVALID_SIGNATURE = "org.freedesktop.DBus.Error.InvalidSignature";
pub const DBUS_ERROR_INVALID_FILE_CONTENT = "org.freedesktop.DBus.Error.InvalidFileContent";
pub const DBUS_ERROR_SELINUX_SECURITY_CONTEXT_UNKNOWN = "org.freedesktop.DBus.Error.SELinuxSecurityContextUnknown";
pub const DBUS_ERROR_ADT_AUDIT_DATA_UNKNOWN = "org.freedesktop.DBus.Error.AdtAuditDataUnknown";
pub const DBUS_ERROR_OBJECT_PATH_IN_USE = "org.freedesktop.DBus.Error.ObjectPathInUse";
pub const DBUS_ERROR_INCONSISTENT_MESSAGE = "org.freedesktop.DBus.Error.InconsistentMessage";
pub const DBUS_ERROR_INTERACTIVE_AUTHORIZATION_REQUIRED = "org.freedesktop.DBus.Error.InteractiveAuthorizationRequired";
pub const DBUS_ERROR_NOT_CONTAINER = "org.freedesktop.DBus.Error.NotContainer";
pub const DBUS_INTROSPECT_1_0_XML_NAMESPACE = "http://www.freedesktop.org/standards/dbus";
pub const DBUS_INTROSPECT_1_0_XML_PUBLIC_IDENTIFIER = "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN";
pub const DBUS_INTROSPECT_1_0_XML_SYSTEM_IDENTIFIER = "http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd";
pub const DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE = "<!DOCTYPE node PUBLIC \"" ++ DBUS_INTROSPECT_1_0_XML_PUBLIC_IDENTIFIER ++ "\"\n\"" ++ DBUS_INTROSPECT_1_0_XML_SYSTEM_IDENTIFIER ++ "\">\n";
pub const DBUS_ERROR_INIT = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/dbus-1.0/dbus/dbus-errors.h:64:9
pub const DBUS_BUS_H = "";
pub const DBUS_CONNECTION_H = "";
pub const DBUS_MEMORY_H = "";
pub const dbus_new = @compileError("unable to translate C expr: unexpected token ')'"); // /usr/include/dbus-1.0/dbus/dbus-memory.h:59:9
pub const dbus_new0 = @compileError("unable to translate C expr: unexpected token ')'"); // /usr/include/dbus-1.0/dbus/dbus-memory.h:60:9
pub const DBUS_MESSAGE_H = "";
pub const DBUS_MESSAGE_ITER_INIT_CLOSED = @compileError("unable to translate C expr: unexpected token '{'"); // /usr/include/dbus-1.0/dbus/dbus-message.h:100:9
pub const DBUS_SHARED_H = "";
pub const DBUS_SERVICE_DBUS = "org.freedesktop.DBus";
pub const DBUS_PATH_DBUS = "/org/freedesktop/DBus";
pub const DBUS_PATH_LOCAL = "/org/freedesktop/DBus/Local";
pub const DBUS_INTERFACE_DBUS = "org.freedesktop.DBus";
pub const DBUS_INTERFACE_MONITORING = "org.freedesktop.DBus.Monitoring";
pub const DBUS_INTERFACE_VERBOSE = "org.freedesktop.DBus.Verbose";
pub const DBUS_INTERFACE_INTROSPECTABLE = "org.freedesktop.DBus.Introspectable";
pub const DBUS_INTERFACE_PROPERTIES = "org.freedesktop.DBus.Properties";
pub const DBUS_INTERFACE_PEER = "org.freedesktop.DBus.Peer";
pub const DBUS_INTERFACE_LOCAL = "org.freedesktop.DBus.Local";
pub const DBUS_NAME_FLAG_ALLOW_REPLACEMENT = @as(c_int, 0x1);
pub const DBUS_NAME_FLAG_REPLACE_EXISTING = @as(c_int, 0x2);
pub const DBUS_NAME_FLAG_DO_NOT_QUEUE = @as(c_int, 0x4);
pub const DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER = @as(c_int, 1);
pub const DBUS_REQUEST_NAME_REPLY_IN_QUEUE = @as(c_int, 2);
pub const DBUS_REQUEST_NAME_REPLY_EXISTS = @as(c_int, 3);
pub const DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER = @as(c_int, 4);
pub const DBUS_RELEASE_NAME_REPLY_RELEASED = @as(c_int, 1);
pub const DBUS_RELEASE_NAME_REPLY_NON_EXISTENT = @as(c_int, 2);
pub const DBUS_RELEASE_NAME_REPLY_NOT_OWNER = @as(c_int, 3);
pub const DBUS_START_REPLY_SUCCESS = @as(c_int, 1);
pub const DBUS_START_REPLY_ALREADY_RUNNING = @as(c_int, 2);
pub const DBUS_MISC_H = "";
pub const DBUS_PENDING_CALL_H = "";
pub const DBUS_TIMEOUT_INFINITE = __helpers.cast(c_int, __helpers.promoteIntLiteral(c_int, 0x7fffffff, .hex));
pub const DBUS_TIMEOUT_USE_DEFAULT = -@as(c_int, 1);
pub const DBUS_SERVER_H = "";
pub const DBUS_SIGNATURES_H = "";
pub const DBUS_SYNTAX_H = "";
pub const DBUS_THREADS_H = "";
pub const inotify_event = struct_inotify_event;
