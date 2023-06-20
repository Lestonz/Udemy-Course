//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson4 { 
    // struct: A data type used to define structures in the Solidity language.
    // A struct represents a data structure made up of different data types.

    struct User {
        string name;
        uint age;
        address walletAddress;
    }

    struct Car {
        string brand;
        uint model;
        User owner;
    }

    User public userForCar;
    Car public carForUser;

    function createOwnerOfCar(string memory _name, uint _age, address _wallet, string memory _brand, uint _model) public {
        userForCar = User(_name, _age, _wallet);
        carForUser = Car(_brand, _model, userForCar);
    }

}