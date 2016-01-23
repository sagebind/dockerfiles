FROM ubuntu:xenial
MAINTAINER "Stephen Coakley <me@stephencoakley.com>"

# Install compiler and linker dependencies.
RUN apt-get update && apt-get -y --no-install-recommends install \
    build-essential \
    file \
    git \
    libreadline6 \
    libreadline6-dev \
    wget \
    mingw-w64 \
    binutils-mingw-w64 \
    gcc-arm-linux-gnueabi \
    binutils-arm-linux-gnueabi \
    gcc-arm-linux-androideabi \
    rm -rf /var/lib/apt/lists/*

# Set up the installer script.
COPY rust-install-pkg.sh /usr/local/bin/rust-install-pkg
RUN chmod +x /usr/local/bin/rust-install-pkg
RUN ln -s /usr/local/lib/rustlib /usr/local/bin/rustlib

# Install packages.
RUN rust-install-pkg 1.5.0-x86_64-unknown-linux-gnu
RUN rust-install-pkg std-1.5.0-i686-pc-windows-gnu
RUN rust-install-pkg std-1.5.0-x86_64-pc-windows-gnu
RUN rust-install-pkg std-1.5.0-arm-unknown-linux-gnueabi
RUN rust-install-pkg std-1.5.0-arm-linux-androideabi

WORKDIR /src
VOLUME ["/src"]

CMD rustc
