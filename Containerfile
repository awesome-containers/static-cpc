# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash

# https://hub.docker.com/_/rust/tags
FROM docker.io/rust:1.69 AS build

# hadolint ignore=DL3008
RUN set -xeu; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential curl musl-dev musl-tools

# https://github.com/probablykasper/cpc
ARG CPC_VERSION=1.9.1

WORKDIR /src/cpc
RUN set -xeu; \
    curl -#Lo cpc.tar.xz \
        "https://github.com/probablykasper/cpc/archive/refs/tags/v$CPC_VERSION.tar.gz"; \
    tar -xvf cpc.tar.xz --strip-components=1; \
    rm -f cpc.tar.xz

ARG RUSTFLAGS='-C target-feature=+crt-static'
RUN set -xeu; \
    rustup target add x86_64-unknown-linux-musl; \
    cargo build --release --target x86_64-unknown-linux-musl

WORKDIR /src/cpc/target/x86_64-unknown-linux-musl/release
RUN set -xeu; \
    strip -s -R .comment --strip-unneeded cpc; \
    chmod -cR 755 cpc; \
    chown -cR 0:0 cpc; \
    ldd cpc; \
    ./cpc --version

# static cpc image
FROM static-bash
COPY --from=build /src/cpc/target/x86_64-unknown-linux-musl/release/cpc /bin/
