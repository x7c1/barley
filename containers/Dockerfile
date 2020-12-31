FROM ubuntu:latest

# required by node.js ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- #

RUN apt-get update -y && \
    apt-get install -y \
        git \
        curl \
        fakeroot \
        dpkg

ENV NVM_DIR /root/.nvm
ENV NVM_VERSION "0.37.2"
ENV NODE_VERSION "14.15.3"

RUN mkdir $NVM_DIR

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION

ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# required by wasm-pack-plugin ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- #

# prevent cmake installer from being stopped when configuring tzdata
# rf. https://stackoverflow.com/a/44333806
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y \
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
RUN cargo install wasm-bindgen-cli
RUN rustup target add wasm32-unknown-unknown
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
