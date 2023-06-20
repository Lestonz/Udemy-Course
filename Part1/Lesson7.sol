//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson7 {
    // storage: is a memory area where permanent data is stored.
    // Storage area represents the contract state on the Ethereum chain.
    // Data held in storage permanently affects the state of the contract and is stored on-chain.
    // Variables inside the contract are kept in storage by default.
    // The storage area is usually used for the permanent state of the contract.

    uint256 public number = 92;

    function changeNumber(uint256 _number) external {
        number = _number;
    }



    // memory: It is a memory area where temporary data is stored.
    // Data created during function calls is kept in memory.
    // memory space is used for temporary processing or copying of large data structures.
    //Variables defined outside the function cannot be kept in the memory area.

    string public word1 = "Hello";

    function connectToWords() external view returns(string memory) {
        string memory word2 = "World!";
   
        string memory combineWord = string(abi.encodePacked(word1, " ", word2));
        return combineWord;
    }



    // storage pointer: These are temporary. It can be thought of as a memory. 
    // It can be used for array, struct or mapping.

    uint256[] internal numbers = [5,6,7];

    function change() external {
        uint256[] storage test = numbers;
        test[1] = 333;
    }

    function arrayRead() external view returns(uint256[] memory) {
        return numbers;
    }
}