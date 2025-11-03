const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // cognitive-export - CSV export tool
    const export_mod = b.createModule(.{
        .root_source_file = b.path("src/export.zig"),
        .target = target,
        .optimize = optimize,
    });
    const export_exe = b.addExecutable(.{
        .name = "cognitive-export",
        .root_module = export_mod,
    });
    export_exe.linkLibC();
    export_exe.linkSystemLibrary("sqlite3");
    b.installArtifact(export_exe);

    // cognitive-stats - Analytics tool
    const stats_mod = b.createModule(.{
        .root_source_file = b.path("src/stats.zig"),
        .target = target,
        .optimize = optimize,
    });
    const stats_exe = b.addExecutable(.{
        .name = "cognitive-stats",
        .root_module = stats_mod,
    });
    stats_exe.linkLibC();
    stats_exe.linkSystemLibrary("sqlite3");
    b.installArtifact(stats_exe);

    // cognitive-query - Advanced search tool
    const query_mod = b.createModule(.{
        .root_source_file = b.path("src/query.zig"),
        .target = target,
        .optimize = optimize,
    });
    const query_exe = b.addExecutable(.{
        .name = "cognitive-query",
        .root_module = query_mod,
    });
    query_exe.linkLibC();
    query_exe.linkSystemLibrary("sqlite3");
    b.installArtifact(query_exe);
}
