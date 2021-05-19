async function main() {
    const factory = await ethers.getContractFactory("ENFT");
    
    // Start deployment, returning a promise that resolves to a contract object
    let contract = await factory.deploy();
    console.log("Contract deployed to address:", contract.address);
    console.log("Transaction hash:", contract.deployTransaction.hash);
    await contract.deployed();
 }
 
 main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });