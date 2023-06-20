//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// bool int uint string bytes address 
contract Lesson3 {
    // bool: A data type that represents a logical value. Values can be either true (1) or false (0).

    bool public myBoolenValue = false;

    // int: Integer (int) Numbers (including negative numbers). Example: int8, int16, int24,....int256

   //int public myIntValue = -19;
    int public secondeInt = -7867868761876123761826387618236871623871627317623776188899123791237912379870; 

     // uint: Integers (Unsigned Integer) (excluding negative numbers). Example: uint8, uint16, uint24,....uint256
     // uint256 = uint = 2**256-1
    uint public myUint = 19;
    uint256 public highValue = 78678687618761237618263876182368716238716273176237761888991237912379123798760;


     // string: A data type that represents text values. It is defined in double quotes.
    string public myWord = "Hello Lestonz!"; 



     // bytes32: It is a data type that represents 32 bytes (256 bits) long data. It is often used to store small pieces of data.
     // 1 byte = 8 bits and hexadecimal format (0x), bytes1...bytes32

    bytes32 public valueBtye = "Hello Lestonz!";
    bytes32 public valueBtyeSecond = "Hello Lestonz?";

     // address: A data type that represents Ethereum addresses. The address type is used to store and interact with Ethereum addresses.
     // hexadecimal format (0x)

    address public myAddress = 0x3328358128832A260C76A4141e19E2A943CD4B6D;

}