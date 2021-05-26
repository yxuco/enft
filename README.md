# Sample NFT

Develop an NFT contract by using [hardhat](https://hardhat.org) and [ethers.js](https://docs.ethers.io/v5).  For fullstack dApp development, you can checkout the UI project [enftapp](https://github.com/yxuco/enftapp) that implements a [React](https://reactjs.org/) UI to interact with this sample NFT contract.

The contract is deployed on `Rinkeby` test net, and can be viewed on [etherscan](https://rinkeby.etherscan.io/address/0xc98e641bbbfab95bd118da10c4d26cdc3f1bd387#code).  Tokens are also listed in marketplace, e.g., [opensea](https://testnets.opensea.io/collection/enft).

## Install node using nvm

Following instruction in <https://github.com/nvm-sh/nvm> to install `nvm`.

Verify `nvm` installation and then install latest version of `node`.

```bash
nvm -v
nvm install node
```

## Create NFT project

Initialize `enft` project:

```bash
mkdir enft
cd enft
npm init
```

Initialize [hardhat](https://hardhat.org) configuration:

```bash
npm install --save-dev hardhat
npx hardhat (select create an empty hardhat.config.js)
mkdir contracts scripts metadata
```

We use [infura](https://infura.io/), [MetaMask](https://metamask.io/) and [etherscan](https://etherscan.io/) to deploy, view and test the contract. So, create a free account on each of the sites.

Create `.env` file at the root of the project and specify the following parameters.

```properties
API_URL="https://rinkeby.infura.io/v3/<infura projectId for rinkeby test net>"
PRIVATE_KEY="<private key from metamask account details>"
PUBLIC_KEY="<metamask account address>"
ETHERSCAN_API_KEY="<etherscan app key"
ENFT_ADDRESS="<contract address returned by deploying the sample contract>"
```

## Implement smart contract

Create and edit contract [ENFT.sol](./contracts/ENFT.sol).

```bash
cd contracts
touch ENFT.sol  (edit ENFT.sol here)
cd ..
npm install @openzeppelin/contracts@3.1.0-solc-0.7
npm install dotenv --save
npm install --save-dev @nomiclabs/hardhat-ethers 'ethers@^5.0.0'
```

Update [hardhat.config.js](./hardhat.config.js).

Compile the contract:

```bash
npx hardhat compile
```

## Deploy smart contract

Create and edit script [deploy.js](./scripts/deploy.js).

```bash
cd scripts
touch deploy.js  (edit deploy.js here)
cd ..
npx hardhat run scripts/deploy.js --network rinkeby
```

Script prints out the contract address, e.g.,

```
Contract deployed to address: 0xc98e641bBbFab95BD118dA10C4D26Cdc3F1bd387
Transaction hash: 0x2e2978ae013097cb357040d9923a53a295b3923bc4c3ad2cfea9a3ed3697311c
```

Verify the contract on etherscan:

```bash
npm install --save-dev @nomiclabs/hardhat-etherscan
npx hardhat verify --network rinkeby 0xc98e641bBbFab95BD118dA10C4D26Cdc3F1bd387
```

## Create ENFT tokens

Upload token images to IPFS:

```bash
curl -X POST -F "file=@metadata/flogo.png" https://ipfs.infura.io:5001/api/v0/add
```

It prints out the resulting hash of the image [flogo.png](./metadata/flogo.png):

```
{"Name":"flogo.png","Hash":"QmV5F12oxAq3ki2Pz4zF2wo4Cn3HoZzGL5r8hDoKLLEFDr","Size":"3667"}
```

```bash
curl -X POST -F "file=@metadata/tibcolab.png" https://ipfs.infura.io:5001/api/v0/add
```

It prints out the resulting hash of the image [tibcolab.png](./metadata/tibcolab.png):

```
{"Name":"tibcolab.png","Hash":"QmUKpXTahUTHMt651HHe4RqsorUrukKuVTU5RMzFkzFp5p","Size":"5311"}
```

Verify the content of the uploaded images in IPFS:

```bash
curl -X POST "https://ipfs.infura.io:5001/api/v0/cat?arg=QmV5F12oxAq3ki2Pz4zF2wo4Cn3HoZzGL5r8hDoKLLEFDr" > tmp.png
curl -X POST "https://ipfs.infura.io:5001/api/v0/cat?arg=QmUKpXTahUTHMt651HHe4RqsorUrukKuVTU5RMzFkzFp5p" > tmp.png
```

Create and edit token metadata file [flogo.json](./metadata/flogo.json) and [tibcolab.json](./metadata/tibcolab.json), which contain references to the uploaded images.

Upload metadata files to IPFS:

```bash
curl -X POST -F "file=@metadata/flogo.json" https://ipfs.infura.io:5001/api/v0/add
```

It prints out the hash for [flogo.json](./metadata/flogo.json).

```
{"Name":"flogo.json","Hash":"QmUqfxdhwktSbuz8kc8rVmWDPP6xUgrwaBAEd3KrKtxfkZ","Size":"387"}
```

```bash
curl -X POST -F "file=@metadata/tibcolab.json" https://ipfs.infura.io:5001/api/v0/add
```

It prints out the hash for [tibcolab.json](./metadata/tibcolab.json).

```
{"Name":"tibcolab.json","Hash":"Qme3QJ9H43kVDDRNrVtbJXo5uUuzqWY2JJyfkqfEHRozf6","Size":"336"}
```

Create and edit script [mint.js](./scripts/mint.js), then execute the script to mint some tokens on the Rinkeby testnet.

```bash
cd scripts
touch mint.js  (edit mint.js here)
cd ..
npx hardhat run scripts/mint.js --network rinkeby
```

This script creates 2 tokens. View them on etherscan <https://rinkeby.etherscan.io/address/0xc98e641bbbfab95bd118da10c4d26cdc3f1bd387#code>, and/or opensea <https://testnets.opensea.io/collection/enft>.
