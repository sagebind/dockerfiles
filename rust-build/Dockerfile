FROM debian:latest

MAINTAINER "Stephen Coakley <me@stephencoakley.com>"

# Install compiler and linker dependencies.
RUN apt-get update && apt-get -y install \
    binutils-mingw-w64 \
    build-essential \
    curl \
    file \
    git \
    mingw-w64 \
    libreadline6 \
    libreadline6-dev \
    wget

# Download the latest native rustc.
RUN curl -sSf https://static.rust-lang.org/rustup.sh | bash -s -- -y --disable-sudo

# Set up the target installer script.
COPY rustc-install-target.sh /usr/local/bin/rustc-install-target
RUN chmod +x /usr/local/bin/rustc-install-target
RUN ln -s /usr/local/lib/rustlib /usr/local/bin/rustlib

# Install some common cross-targets.
RUN rustc-install-target arm-unknown-linux-gnueabihf
RUN rustc-install-target i686-pc-windows-gnu
RUN rustc-install-target x86_64-pc-windows-gnu

COPY cargo-config /root/.cargo/config

WORKDIR /src
VOLUME ["/src"]

CMD rustc
