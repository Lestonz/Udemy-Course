//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson14 { 
    /* Event - Emit */

    string public message;
    uint internal number;

    event messageControl (string message, uint number, address sender);

    function messageSend(string memory _message, uint _number) external {
        message = _message;
        number = _number;
        emit messageControl(_message, _number, msg.sender);
    }

}