//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson8 {
    /*
         enum: A data type used in the Solidity language and used to represent a set of constant values.
         Therefore, it is possible to select only one of the defined values when using an enum.
     */
    //            0 ,     1 ,    2,    3,     4
    enum Colors {Red, Yellow, Blue, Orange, White}

    Colors internal prefer;

    function firstPrefer(uint8 _index) external {
        prefer = Colors(_index);
    }

    function secondPrefer(Colors _index) external {
        prefer = Colors(_index);
    }

    function thirdPrefer() external {
        prefer = Colors.White;
    }



    function valueColor() external view returns(Colors) {
        return prefer;
    }
}