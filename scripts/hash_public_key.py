import sys
from web3 import Web3

public_key = sys.argv[1]
address = Web3.keccak(hexstr = public_key).hex()
address = "0x" + address[-40:]
print(address)