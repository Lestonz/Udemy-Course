//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

//inheritance and import

// virtual and override
import "./Lesson15_A.sol";

contract Lesson15_B is Lesson15_A {

    function numberAdd( uint _number1, uint _number2) external override {
        total = (_number1 + _number2) **2 ; 
    } 

    function numberSubt( uint _number1, uint _number2) external override {
        require(_number1 > _number2, "Number 1 should be greter than number 2");
        total = _number1 - _number2;
    }
}