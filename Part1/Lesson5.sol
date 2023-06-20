//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson5 {
    // mapping: A data structure that provides a key-value mapping in the Solidity language.
    // The Mapping data structure ensures that a key is associated with its value.
    // Keys are variables that are often used to provide a unique ID in a data structure.

    mapping (address => uint256) public balance;

    function deposit() public payable {
        //msg.sender who calling the this funtion
        //msg.value sending of value ether wei gwei

        // "+=" is equal to => balance[msg.sender] = balance[msg.sender] + msg.value
        balance[msg.sender] += msg.value;
    }

    function withdrawMoney(uint256 _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient Balance");
        balance[msg.sender] -= _amount;

        payable(msg.sender).transfer(_amount);
    }
} 