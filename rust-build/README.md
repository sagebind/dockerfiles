# rust-build
Rust build environment and cross-compiler

A Docker image configured with a full Rust build environment. Includes `rustc` and `cargo`, and is set up with cross-compiling enabled for common targets. Included are also C/C++ compilers and linkers for compiling for GNU ABI targets, such as `mingw` for Windows.

Yes, you can compile for Windows on Linux with the installed compiler. If you're using Cargo, you can simply run `cargo build --target=x86_64-pc-windows-gnu` to compile your program to a native Windows `.exe`. Pretty cool, no?
