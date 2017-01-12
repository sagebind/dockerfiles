FROM ubuntu:16.04

ARG RUSTC_VERSION=1.14.0
ARG MUSL_VERSION=1.1.14
ARG LLVM_VERSION=3.7.0

# Install necessary dependencies for building.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        git \
        libtool \
        musl-tools \
        python \
        wget \
        xz-utils

# We will do all of our build work in this directory.
WORKDIR /build

ENV CFLAGS="-fPIC -Wa,-mrelax-relocations=no"
ENV CXXFLAGS="-Wa,-mrelax-relocations=no"

# Download and compile MUSL.
RUN curl http://www.musl-libc.org/releases/musl-${MUSL_VERSION}.tar.gz | tar xzf - && \
    cd musl-${MUSL_VERSION} && \
    ./configure --prefix=/musl-x86_64 --disable-shared && \
    make -j10 && \
    make install

# We will need libunwind for rustc, so download and compile it against MUSL.
RUN curl -L http://llvm.org/releases/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz | tar xJf - && \
    curl -L http://llvm.org/releases/${LLVM_VERSION}/libunwind-${LLVM_VERSION}.src.tar.xz | tar xJf - && \
    mkdir libunwind-build && \
    cd libunwind-build && \
    cmake ../libunwind-${LLVM_VERSION}.src -DLLVM_PATH=/build/llvm-${LLVM_VERSION}.src -DLIBUNWIND_ENABLE_SHARED=0 && \
    make -j10 && \
    cp lib/libunwind.a /musl-x86_64/lib

# Now build a MUSL native GCC toolchain using musl-cross-make.
RUN git clone https://github.com/richfelker/musl-cross-make && \
    cd musl-cross-make && \
    echo "TARGET = x86_64-linux-musl" >> config.mak && \
    echo "OUTPUT = /musl-x86_64" >> config.mak && \
    make && \
    make install && \
    rm /musl-x86_64/bin/musl-gcc && \
    rename -v 's/x86_64-linux-//' /musl-x86_64/bin/x86_64-linux-musl-*

COPY config.toml .

COPY builder.sh /builder.sh
ENTRYPOINT ["sh", "/builder.sh"]
