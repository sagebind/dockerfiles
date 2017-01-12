#!/bin/sh
RUSTC_VERSION=$1
TARGET=x86_64-unknown-linux-musl
PATH=/musl-x86_64/bin:$PATH

echo "Compiling rustc $RUSTC_VERSION for $TARGET..."

# Compile rustc using our prepared MUSL toolchain.
cd /build
curl -L https://static.rust-lang.org/dist/rustc-${RUSTC_VERSION}-src.tar.gz | tar xzf -

cd rustc-${RUSTC_VERSION}
./configure --enable-rustbuild
cp /build/config.toml ./
make
