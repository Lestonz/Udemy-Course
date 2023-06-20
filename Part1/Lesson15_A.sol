//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson15_A {
    uint public total;

    function numberAdd( uint _number1, uint _number2) external virtual {
        total = _number1 + _number2;
    }

    function numberMult( uint _number1, uint _number2) external {
        total = _number1 * _number2;
    }

    function numberSubt( uint _number1, uint _number2) external virtual {
        total = _number1 - _number2;
    }


    function numberDivi( uint _number1, uint _number2) external {
        total = _number1 / _number2;
    }


}