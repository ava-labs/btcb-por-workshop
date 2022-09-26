#!/bin/bash

# Exit on any errors
set -e

# Public Fuji API
api_endpoint=https://api.avax-test.network/ext/bc/C/rpc

# Key files
private_key_file=test_wallet_private_key.dat
public_key_file=test_wallet_public_key.dat

# Determine which directory we're in.
current_dir="$(basename $(pwd))"
if [[ "$current_dir" == "btcb-por-workshop" ]]; then
    scripts_directory_prefix=./scripts
    contracts_directory_prefix=./contracts
elif [[ "$current_dir" == "scripts" ]]; then
    scripts_directory_prefix=.
    contracts_directory_prefix=../contracts
else
    echo "Error: Scripts must be run from base directory of repository or from scripts/."
    exit 1
fi

# If the key file exists, use it. Otherwise generate a new wallet.
if [[ -f "$private_key_file" ]]; then
    private_key=$(cat $private_key_file)
    address=$(python3 $scripts_directory_prefix/private_key_to_address.py $private_key)
    echo "Using Test Wallet Address: $address"
else
    echo "Generating new test wallet."
    openssl ecparam -name secp256k1 -genkey -noout | openssl ec -text -noout > secp256k1_key.dat
    cat secp256k1_key.dat | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^04//' > $public_key_file
    cat secp256k1_key.dat | grep priv -A 3 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^00//' > $private_key_file
    private_key=$(cat $private_key_file)
    public_key=$(cat $public_key_file)
    address=$(python3 $scripts_directory_prefix/hash_public_key.py $public_key)

    echo "New Test Wallet Private Key: $private_key"
    echo "New Test Wallet Address: $address"
    echo "DO NOT USE THIS WALLET ON MAINNET."
    echo
fi

# Wait until the wallet has atleast 0.5 AVAX.
balance=$(cast balance --rpc-url $api_endpoint $address)
until [ $balance -gt  500000000000000000 ]
do
    echo "Waiting for at least 0.5 AVAX to be sent to $address."
    sleep 3
    balance=$(cast balance --rpc-url $api_endpoint $address)
done
echo "Address has sufficient balance to deploy sample contract."

# Wait for user to press a key.
read -p "Press any key to continue."

# Deploy the sample DeFi contract to the network.
echo "Deploying sample DeFi contract..."
cd $contracts_directory_prefix
deploy_result=$(forge create --private-key $private_key src/SampleDeFiContract.sol:SampleDeFiContract --rpc-url $api_endpoint)
echo "Deployed sample DeFi contract."

# Parse the contract address and transaction ID.
contract_address=$(echo $deploy_result | grep -o -P 'Deployed to: .{42}' | sed 's/^.\{13\}//')
deploy_tx_hash=$(echo $deploy_result | grep -o -P 'Transaction hash: .{66}' | sed 's/^.\{18\}//')
echo "Deployed contract to: $contract_address"
echo "Deployment transaction ID: $deploy_tx_hash"

# Wait for user to press a key.
read -p "Press any key to continue."

# Call the contract methods to check if BTC.b is fully collateralized.
collateral_amounts=$(cast call $contract_address "getCollateralAmounts()(uint256,int256)" --rpc-url https://api.avax-test.network/ext/bc/C/rpc)
collateralized_result=$(cast call $contract_address "isFullyCollateralized()(bool)" --rpc-url https://api.avax-test.network/ext/bc/C/rpc)
collateral_amounts_arr=($collateral_amounts)
token_supply=${collateral_amounts_arr[0]}
collateral=${collateral_amounts_arr[1]}
echo "BTC.b total supply: $token_supply"
echo "BTC collateral:     $collateral"
if [[ "$collateralized_result" == "true" ]]; then
    echo "BTC.b is fully collateralized."
else
    echo "BTC.b is missing proper collateral."
fi
