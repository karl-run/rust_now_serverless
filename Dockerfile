FROM rust:1.30-slim as base
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake musl-tools ruby && \
    rustup target add x86_64-unknown-linux-musl
WORKDIR /usr/src
COPY Cargo.lock Cargo.toml /usr/src/
COPY src /usr/src/src
RUN cargo build --target x86_64-unknown-linux-musl --release --locked
RUN ls -al target/x86_64-unknown-linux-musl/release/

FROM alpine:3.8
WORKDIR /usr/src
COPY --from=base /usr/src/target/x86_64-unknown-linux-musl/release/now_rust_serverless .
CMD ["./now_rust_serverless"]
