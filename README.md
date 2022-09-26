# Avalanche BTC.b Proof-of-Reserves Demo

This repository contains demo contracts and scripts for interacting with the BTC.b Proof-of-Reserves
Chainlink feed on the Fuji testnet, and integration it into a sample DeFi contract.

It is not meant to be used in any production setting.

### Dependencies
- OpenSSL
- Python3
- Web3
- Foundry

### Installing and Running
- `git clone git@github.com:ava-labs/btcb-por-workshop.git`
- `cd btcb-por-workshop`
- `git submodule update --init --recursive`
- `./scripts/deploy_and_interact.sh`