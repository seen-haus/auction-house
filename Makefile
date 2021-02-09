all    :; dapp build
clean  :; dapp clean
build  :; dapp --use solc:0.8.0 build
test   :; dapp --use solc:0.8.0 build; hevm dapp-test --rpc=<YOUR ETH RPC> --json-file=out/dapp.sol.json --dapp-root=. --verbose 1
deploy :; dapp create AuctionHouse
