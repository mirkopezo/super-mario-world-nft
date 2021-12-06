const { ethers } = require("hardhat");

async function main() {
  const SuperMarioWorldOZ = await ethers.getContractFactory("SuperMarioWorldOZ");
  const superMarioWorldOZ = await SuperMarioWorldOZ.deploy("SuperMarioWorldOZ", "SPRMO");
  await superMarioWorldOZ.deployed();
  console.log("Success! Contract was deployed to: ", superMarioWorldOZ.address);
  await superMarioWorldOZ.mint("https://ipfs.io/ipfs/QmTE7zVkgJhBoNt1YPDsrAMGjZwwy8gGLekZDP6U371Msc");
  console.log("NFT successfully minted!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
