const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const exe = b.addExecutable("test", null);
    const flags = [_][]const u8{ "-Isrc/custom", "-D_GNU_SOURCE", "-fPIC", "-fpermissive", "-DDEV_BUILD" };
    exe.addCSourceFile("src/bin/4ed_build.cpp", &flags);
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("c++");

    b.default_step.dependOn(&exe.step);

    const run_cmd = exe.run();
    const run_step = b.step("run", "Run the program");
    run_step.dependOn(&run_cmd.step);
}
