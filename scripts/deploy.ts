import { ethers } from "hardhat";
// const { ethers } = require("hardhat");

async function main() {
  const CarSharing = await ethers.getContractFactory("CarSharing");
  const carSharing = await CarSharing.deploy();
  await carSharing.deployed();
  console.log("CarSharing contract deployed to:", carSharing.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
