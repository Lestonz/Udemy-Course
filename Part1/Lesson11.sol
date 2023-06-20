//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson11 { 
    // if else 

    uint[] internal numbers;

    // continue

    function forContinueLoop() external {
        for(uint i = 0; i < 15; i++) {
            if (i == 7 || i == 9) {
                numbers.push(i);
            } else {
                continue;
            }
        }
    }

    // break
    function forBreakLoop() external {
        for(uint i = 0; i < 15; i++) {
            if (i == 7 ) {           
                break;
            } else {
                numbers.push(i);
            }
        }
    }

    function control(string memory _word) external pure returns (string memory) {
        if (keccak256(bytes(_word)) == keccak256(bytes("Cat")) ) {
            return "True, you find first word.";
        } else if (keccak256(bytes(_word)) == keccak256(bytes("Dog")) ) {
            return "True, you find second word.";
        }
        else {
            return "Try again.";
        }
    }


    function numbersArray() external view returns (uint[] memory) {
        return numbers;
    }

}