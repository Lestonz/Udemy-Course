//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson10 {
    //For Loop

    uint[] internal numbers;

    function forLoop() external {
        for(uint i = 0; i <= 100; i++ ) {
            numbers.push(i);
        }
    }

    function numbersArray() external view returns (uint[] memory) {
        return numbers;
    }

}