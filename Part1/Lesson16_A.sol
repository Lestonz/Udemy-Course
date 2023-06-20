//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./ILesson16.sol";

contract Lesson16_A {
    uint public number = 0;

    function changeNumber(uint _number) external {
        number = _number;
    }
}