//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson9 {
    // While

    uint[] internal numbers;

    uint internal index=0;
    uint internal finishNumber = 100;

    function whileLoop() external {
        while (index <= finishNumber){
            numbers.push(index);
            /*index = index + 1;  */
            index ++;
        }
    }

    function numbersArray() external view returns (uint[] memory) {
        return numbers;
    }
}