// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// Public Internal External View Pure  
contract Lesson2 {
    // Public: This term can be accessed and invoked from other contracts or the outside world.
    uint256 public number1 = 35;
    uint256 number2 = 25;

    function changeNumber(uint256 _number) public  {
        number1 = _number;
    }

    // Internal: This term means that it can only be called from within internal contracts, 
    // that is, from within the same contract or from inheriting contracts.

    string internal user = "Lestonz";

    function pureInternal() internal pure returns (string memory) {
        return "Hello Internal Function";
    }


    // External: This term simply means that it can be called externally, from another contract.
    function changeUserName(string memory _userName) external {
        user = _userName;
    }


    // View: This term means that it should not change the contract state and write no data.

    function internalUserName() public view returns (string memory) {
        return user;
    }

    // Pure: This term means that it should not change the external state or any contract state.

    function internalToPublic() public pure returns (string memory) {
        return pureInternal(); 
    }

}