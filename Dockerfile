FROM ubuntu:22.04
ARG TARGETARCH
ENV HTTP_HOST="0.0.0.0"

ENV TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl build-essential libssl-dev cmake pkg-config openssl
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup target add wasm32-unknown-unknown && cargo install wasm-bindgen-cli && cargo install --locked trunk
RUN cd frontend && trunk build && cd ..


RUN cargo build --release --locked --target x86_64-unknown-linux-gnu -manifest-path backend/Cargo.toml




COPY backend/target/x86_64-unknown-linux-gnu/release/mailcrab-backend /app/mailcrab
WORKDIR /app




CMD ["/app/mailcrab"]
EXPOSE 1080 1025
