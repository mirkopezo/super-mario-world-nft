const { ethers } = require("hardhat");

async function main() {
  const SuperMarioWorldERC1155OZ = await ethers.getContractFactory("SuperMarioWorldERC1155OZ");
  const superMarioWorldERC1155OZ = await SuperMarioWorldERC1155OZ.deploy("SuperMarioWorldERC1155OZ", "SPREOZ");
  await superMarioWorldERC1155OZ.deployed();
  console.log("Success! Contract was deployed to: ", superMarioWorldERC1155OZ.address);
  await superMarioWorldERC1155OZ.mint(50, "https://ipfs.io/ipfs/Qmc3KuB5C8VEQYySaue6yYr5DPzczxmhdjksnHKnVGAhsS");
  console.log("NFT successfully minted!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
