//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lesson12 { 
    // revert assert require 

    function control1(uint _number) external pure returns(uint) {
        if (_number > 11) {
            return _number;
        } else {
            return 0;
        }
    }

    // revert 
    function control2(uint _number) external pure returns(uint) {
        if (_number > 11) {
            return _number;
        } else {
            revert("Number is not greater than 11");
        }
    }   

    // assert
    function control3(uint _number) external pure returns(uint) {
         assert(_number > 11);
         return _number;
    }


    // require
    function control4(uint _number) external pure returns(uint) {
        require(_number > 11, "Number is not greater than 11");
        return _number;
    }
}