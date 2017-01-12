#!/bin/sh

set -ex

export CFLAGS="-fPIC -Wa,-mrelax-relocations=no"
export CXXFLAGS="-Wa,-mrelax-relocations=no"
MUSL=musl-1.1.14
# Support building MUSL
curl http://www.musl-libc.org/releases/$MUSL.tar.gz | tar xzf -
cd $MUSL
# for x86_64
./configure --prefix=/musl-x86_64 --disable-shared
make -j10
make install
make clean
cd ..

# To build MUSL we're going to need a libunwind lying around, so acquire that
# here and build it.
curl -L http://llvm.org/releases/3.7.0/llvm-3.7.0.src.tar.xz | tar xJf -
curl -L http://llvm.org/releases/3.7.0/libunwind-3.7.0.src.tar.xz | tar xJf -
mkdir libunwind-build
cd libunwind-build
# for x86_64
cmake ../libunwind-3.7.0.src -DLLVM_PATH=/build/llvm-3.7.0.src \
          -DLIBUNWIND_ENABLE_SHARED=0
make -j10
cp lib/libunwind.a /musl-x86_64/lib
