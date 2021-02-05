all    :; dapp build
clean  :; dapp clean
build  :; dapp --use solc:0.8.0 build
test   :; dapp --use solc:0.8.0 build; hevm dapp-test --rpc=https://mainnet.infura.io/v3/73dc63290c73465d8b659ce17028909f --json-file=out/dapp.sol.json --dapp-root=. --verbose 1
deploy :; dapp create AuctionHouse
