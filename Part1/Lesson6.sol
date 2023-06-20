//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson6 {
    // Fixed Size Arrays: Fixed size arrays are arrays that have a predetermined size. 
    // Its size cannot be changed after it is created.

    string[3] public words;

    function addArrayValueI() external {
        words = ["Cat", "Dog", "Mouse"];
    }

    // Dynamically Sized Arrays (Dynamic Array): Dynamic-size arrays are arrays whose size 
    // can be determined at runtime. Dimensions can be changed optionally.
    uint256[] internal numbers = [1, 3, 44, 55];
    // Array of index number      0,  1, 2, 3           
    function readNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    // push
    function addNumber(uint _number) external {
        numbers.push(_number);
    }


    // pop
    function removeNumber() external {
        require(numbers.length > 0, "This Array is Empty!");
        numbers.pop();
    }


    // delete
    function deleteNumber(uint _index) external {
        require(numbers.length > _index, "There is no value with this index number in this array.");
        delete numbers[_index];
    }


}