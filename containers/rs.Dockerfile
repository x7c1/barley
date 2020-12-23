FROM ubuntu:latest

# prevent cmake installer from being stopped when configuring tzdata
# rf. https://stackoverflow.com/a/44333806
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y \
        git \
        curl \
        cmake \
        libssl-dev \
        pkg-config \
        g++

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /usr/bin/rustup-init
RUN chmod +x /usr/bin/rustup-init && rustup-init -y

# setup rust tools
ENV CARGO_DIR /root/.cargo
ENV PATH $CARGO_DIR/bin:$PATH
RUN cargo install trunk wasm-bindgen-cli
RUN rustup target add wasm32-unknown-unknown
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
