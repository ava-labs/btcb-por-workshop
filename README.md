# Avalanche BTC.b Proof-of-Reserves Demo

This repository contains demo contracts and scripts for interacting with the BTC.b Proof-of-Reserves
Chainlink feed on the Fuji testnet, and integration it into a sample DeFi contract.

It is not meant to be used in any production setting.

### Dependencies for running locally
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

### Running Locally
- `git clone git@github.com:ava-labs/btcb-por-workshop.git`
- `cd btcb-por-workshop`
- `git submodule update --init --recursive`
- `./scripts/deploy_and_interact.sh`

### Dependencies for running with Docker (optional)
- Install [Docker](https://www.docker.com/):
```bash
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker # Docker will start automatically on future system boots
```
- Install Docker compose
```bash
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
docker compose version
```
- Set Docker to run without `sudo`:
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot
docker run hello-world # This should work without sudo now
```

### Running with docker
- `git clone git@github.com:ava-labs/btcb-por-workshop.git`
- `cd btcb-por-workshop`
- `git submodule update --init --recursive`
- `./scripts/run_using_docker.sh`