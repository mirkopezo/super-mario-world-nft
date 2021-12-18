const { ethers } = require("hardhat");

async function main() {
  const SuperMarioWorldERC1155 = await ethers.getContractFactory("SuperMarioWorldERC1155");
  const superMarioWorldERC1155 = await SuperMarioWorldERC1155.deploy("SuperMarioWorldERC1155", "SPRME");
  await superMarioWorldERC1155.deployed();
  console.log("Success! Contract was deployed to: ", superMarioWorldERC1155.address);
  await superMarioWorldERC1155.mint(10, "https://ipfs.io/ipfs/QmRpPXTbmZoLPNcHpLJ3mvenUofzB6LUFHxuiXq5p46bjS");
  console.log("NFT successfully minted!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
