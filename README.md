# Old Seen Haus Auction House contracts
## THIS REPO IS DEPRECATED!
All new work should be performed in the [seen-contracts](https://github.com/seen-haus/seen-contracts) repo.
Everything here (except the Makefile) has been moved to the new repo, which uses [Hardhat](https://github.com/nomiclabs/hardhat) tools to build, test, and deploy.

---
## What's here?
Not all the deployed Seen.haus contracts are in this repo; some were deployed from a
dev's local browser/Remix and never made it into the repo. Go figure.


In this code you can see
- an auction house factory which works with any ERC1155 token contract
- xSEEN: the seen governance token which earns fees in SEEN on all auctions finished
- A fork of the compound governor alpha and timelock for long term governance


## Build and Test
This repo uses the [DappHub](https://github.com/dapphub) tools platform for building. 
Sorry there isn't any documentation here for how to get that tooling going, 
but it doesn't matter now, because you're not going to be building this anyway, right?

- Modify `Makefile` to add your ETH RPC
- `make test`
