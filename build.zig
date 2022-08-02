const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const flags = [_][]const u8{ "-Isrc", "-Isrc/custom", "-D_GNU_SOURCE", "-fPIC", "-fpermissive", "-DDEV_BUILD" };

    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("test", null);

    exe.addCSourceFile("src/bin/4ed_build.cpp", &flags);
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("c++");
    // exe.linkLibC();

    b.default_step.dependOn(&exe.step);

    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // const exe_tests = b.addTest("src/main.zig");
    // exe_tests.setTarget(target);
    // exe_tests.setBuildMode(mode);

    // const test_step = b.step("test", "Run unit tests");
    // test_step.dependOn(&exe_tests.step);
}
