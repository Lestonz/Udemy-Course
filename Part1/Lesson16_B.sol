//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./ILesson16.sol";
contract Lesson16_B {
    
    ILesson16 public targetContract;

    // intervene of function
    function outSideContract(address _contractAddress) external {
        targetContract = ILesson16(_contractAddress);
    }

    // Func written to interface with contract A
    function test(uint _number) external {
        targetContract.changeNumber(_number);
    }


}