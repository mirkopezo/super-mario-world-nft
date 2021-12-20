const { ethers } = require("hardhat");

async function main() {
  const SuperMarioWorldCollection = await ethers.getContractFactory(
    "SuperMarioWorldCollection"
  );
  const superMarioWorldCollection = await SuperMarioWorldCollection.deploy(
    "SuperMarioWorldCollection",
    "SPWC",
    "https://ipfs.io/ipfs/Qmb6tWBDLd9j2oSnvSNhE314WFL7SRpQNtfwjFWsStXp5A/"
  );
  await superMarioWorldCollection.deployed();
  console.log(
    "Success! Contract was deployed to: ",
    superMarioWorldCollection.address
  );
  await superMarioWorldCollection.mint(10);
  await superMarioWorldCollection.mint(10);
  await superMarioWorldCollection.mint(10);
  await superMarioWorldCollection.mint(10);
  await superMarioWorldCollection.mint(2);
  await superMarioWorldCollection.mint(2);
  await superMarioWorldCollection.mint(2);
  await superMarioWorldCollection.mint(2);
  console.log("NFTs successfully minted!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
