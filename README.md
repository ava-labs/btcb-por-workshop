# Avalanche BTC.b Proof-of-Reserves Demo

This repository contains demo contracts and scripts for interacting with the BTC.b Proof-of-Reserves
Chainlink feed on the Fuji testnet, and integration it into a sample DeFi contract.

It is not meant to be used in any production setting.

### Dependencies
- [OpenSSL](https://www.openssl.org/)
  - `sudo libssl-dev`
- [Python3](https://www.python.org/downloads/)
  - `sudo apt install software-properties-common`
  - `sudo add-apt-repository ppa:deadsnakes/ppa`
  - `sudo apt update`
  - `sudo apt install python3.8`
- [Web3](https://pypi.org/project/web3/)
  - `sudo apt-get -y install python3-pip`
  - `pip install web3`
- [Foundry](https://github.com/foundry-rs/foundry)
  - `curl -L https://foundry.paradigm.xyz | bash`
  - `source ~/.bashrc`
  - `foundryup`

### Installing and Running
- `git clone git@github.com:ava-labs/btcb-por-workshop.git`
- `cd btcb-por-workshop`
- `git submodule update --init --recursive`
- `./scripts/deploy_and_interact.sh`
