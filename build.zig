const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const exe = b.addExecutable("test", null);
    exe.addCSourceFile("src/bin/4ed_build.cpp", &[_][]const u8{"-D_GNU_SOURCE -fPIC -fpermissive -DDEV_BUILD -Isrc/custom"});
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("c++");

    b.default_step.dependOn(&exe.step);

    const run_cmd = exe.run();
    const run_step = b.step("run", "Run the program");
    run_step.dependOn(&run_cmd.step);
}
