FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Install OpenSSL, CURL, Python3, and git
RUN apt-get update && \
    apt-get install -y libssl-dev curl python3 git

# Install Web3
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip install web3

# Install foundry
SHELL ["/bin/bash", "-c"]
RUN curl -L https://foundry.paradigm.xyz | bash && \
    echo "export PATH=\"$PATH:/$HOME/.foundry/bin\"">> ~/.bashrc && \
    source ~/.bashrc && \
    export PATH=$PATH:$HOME/.foundry/bin && \
    foundryup