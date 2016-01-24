FROM ubuntu:xenial
MAINTAINER "Stephen Coakley <me@stephencoakley.com>"

# Install compiler and linker dependencies.
RUN apt-get update && apt-get -y install \
        build-essential \
        ca-certificates \
        curl \
        git \
        lib32c-dev \
        mingw-w64 \
        binutils-mingw-w64 \
        gcc-5-arm-linux-gnueabihf \
        binutils-arm-linux-gnueabihf \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/arm-linux-gnueabihf-gcc-5 /usr/bin/arm-linux-gnueabihf-gcc

# Set up the installer script.
COPY rust-install-pkg.sh /usr/local/bin/rust-install-pkg
RUN chmod +x /usr/local/bin/rust-install-pkg
RUN ln -s /usr/local/lib/rustlib /usr/local/bin/rustlib

# Install packages.
RUN rust-install-pkg 1.5.0-x86_64-unknown-linux-gnu \
    && rust-install-pkg std-1.5.0-i686-unknown-linux-gnu \
    && rust-install-pkg std-1.5.0-x86_64-pc-windows-gnu \
    && rust-install-pkg std-1.5.0-i686-pc-windows-gnu \
    && rust-install-pkg std-1.5.0-arm-unknown-linux-gnueabihf \
    && rustc --version

COPY cargo.config /root/.cargo/config

WORKDIR /src
VOLUME ["/src"]

CMD rustc
