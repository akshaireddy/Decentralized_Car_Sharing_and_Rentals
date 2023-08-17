// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarSharing {
    address public owner;
    uint256 public carCount;

    enum CarStatus { Available, Rented }

    struct Car {
        uint256 id;
        string name;
        CarStatus status;
        address renter;
    }

    mapping(uint256 => Car) public cars;

    event CarAdded(uint256 carId, string name);
    event CarRented(uint256 carId, address renter);
    event CarReturned(uint256 carId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCar(string memory _name) public onlyOwner {
        carCount++;
        cars[carCount] = Car(carCount, _name, CarStatus.Available, address(0));
        emit CarAdded(carCount, _name);
    }

    function rentCar(uint256 _carId) public payable {
        Car storage car = cars[_carId];
        require(car.status == CarStatus.Available, "Car is not available");
        
        car.status = CarStatus.Rented;
        car.renter = msg.sender;
        
        emit CarRented(_carId, msg.sender);
    }

    function returnCar(uint256 _carId) public {
        Car storage car = cars[_carId];
        require(car.status == CarStatus.Rented, "Car is not rented");
        require(car.renter == msg.sender, "Only the renter can return the car");
        
        car.status = CarStatus.Available;
        car.renter = address(0);
        
        emit CarReturned(_carId);
    }
}
