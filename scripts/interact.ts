const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  const contractAddr = process.env.CONTRACT_ADDRESS
  const CarSharing = await ethers.getContractFactory("CarSharing");
  const carSharing = await CarSharing.attach(contractAddr);

  // Interact with the contract here
  const carName = "MyCar";
  await carSharing.addCar(carName); // Add a new car

  const carId = 1;
  await carSharing.rentCar(carId, { value: ethers.utils.parseEther("0.1") }); // Rent the car

  await carSharing.returnCar(carId); // Return the car

  const carStatus = await carSharing.cars(carId); // Get car status
  console.log(`Car ${carId} status: ${carStatus.status}`);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
