//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson13 { 
    // Modifiers and Constructor

    address public ownerOfContract;

    string public message;

    constructor() {
        ownerOfContract = msg.sender;
        message = "Hello Lestonz!";
    }

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == ownerOfContract, "Only Owner Call This Func!");
        _; //Contiune
    }

    function changeToMessage(string memory _message) external onlyOwner {
        message = _message;
    }

    function changeOfTheContractOwner(address _address) external onlyOwner {
        ownerOfContract = _address;
    }


}