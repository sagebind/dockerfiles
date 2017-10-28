FROM debian:stable-slim
MAINTAINER "Stephen Coakley <me@stephencoakley.com>"
ARG TOOLCHAIN=stable

ENV PATH="/root/.cargo/bin:${PATH}"
ENV RUST_BACKTRACE=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential ca-certificates git gzip libssl-dev openssl pkg-config ssh tar
COPY rustup-init /rustup-init
RUN /rustup-init -y --default-toolchain $TOOLCHAIN && \
    rm /rustup-init && \
    rustc --version
