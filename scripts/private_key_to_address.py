import sys
from eth_account import Account
from eth_account.signers.local import LocalAccount

private_key = sys.argv[1]
if ~private_key.startswith("0x"):
    private_key = "0x" + private_key

account: LocalAccount = Account.from_key(private_key)
print(account.address)