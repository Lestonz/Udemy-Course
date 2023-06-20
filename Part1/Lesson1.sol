// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


contract HelloLestonz {

    uint256 number; // 0

    /* Write number function */
    function giveNumber(uint256 _number) public {
        number = _number;
    }

    // Only read function
    function sayHello() public pure returns (string memory) {
        return "Welcome to Lestonz Solidity Course";
    }

    // Read a number function
    function readNumber() public view returns (uint256) {
        return number;
    }

}