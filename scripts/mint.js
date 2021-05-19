require('dotenv').config();
const PUBLIC_KEY = process.env.PUBLIC_KEY;

async function main() {
    const accounts = await ethers.provider.listAccounts();
    console.log("Configured accounts:", accounts);

    // ENFT contract address deployed in rinkeby
    const address = process.env.ENFT_ADDRESS;
    const factory = await ethers.getContractFactory("ENFT");
    const contract = factory.attach(address);

    // mint token for flogo.json
    await contract.mintNFT(PUBLIC_KEY, "https://ipfs.io/ipfs/QmUqfxdhwktSbuz8kc8rVmWDPP6xUgrwaBAEd3KrKtxfkZ");
    // mint token for tibcolab.json
    await contract.mintNFT(PUBLIC_KEY, "https://ipfs.io/ipfs/Qme3QJ9H43kVDDRNrVtbJXo5uUuzqWY2JJyfkqfEHRozf6");

    // get total count
    value = await contract.getCount();
    console.log("ENFT count is", value.toString());
}

main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });
