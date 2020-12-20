FROM ubuntu:latest

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
