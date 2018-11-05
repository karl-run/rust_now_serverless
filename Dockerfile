FROM rust:1.30-slim as base
WORKDIR /usr/src
COPY Cargo.lock Cargo.toml /usr/src/
COPY src /usr/src/src
RUN cargo build --release
RUN ls -all target/release

FROM alpine:3.7
WORKDIR /usr/src
COPY --from=base /usr/src/target/release .
RUN ls -al
CMD ["./now_rust_serverless"]
