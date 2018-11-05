FROM rust:1.30-slim as base
WORKDIR /usr/src
COPY Cargo.lock Cargo.toml /usr/src/
COPY src /usr/src/src
RUN cargo build --release

FROM rust:1.30-slim
WORKDIR /usr/src
COPY --from=base /usr/src/target/release/now_rust_serverless .
CMD ["./now_rust_serverless"]
