// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract LestonzGame is ReentrancyGuard {

    address public owner;
    uint public totalBalance;
    uint public luckyNumber;

    bool public isActive;
    uint public entryPrice = 5 ether;

    event Deposit(address indexed player, uint amount);
    event Winner(address indexed player, uint amount);

    constructor() {
        owner = msg.sender;
        isActive = true;
    }

    modifier gameController() {
        require(isActive, "The game is currently inactive!");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner has calling this function!");
        _;
    }

    function generateRandomNumber() private view returns(uint) {
        return (uint(keccak256(abi.encodePacked(block.timestamp, block.coinbase, block.number))) % 10 );
    }

    function startGame() private {
        isActive = true;
    }

    function changeOfTheEntryPrice(uint _price) external onlyOwner {
        entryPrice = _price;
    }

    function playGame(uint8 _number) external payable  gameController nonReentrant{
        require(_number >= 0 && _number < 10, "The number must be a value between 0-9!");
        require(msg.value >= entryPrice, "You have not deposited enough entrance fees");
        
        totalBalance += msg.value;
        emit Deposit(msg.sender, msg.value);

        luckyNumber = generateRandomNumber();

        if( luckyNumber == _number ) {
            isActive = false;
            uint reward = totalBalance;
            totalBalance = 0;

            (bool winner, ) = payable(msg.sender).call{value : reward}('');
            require(winner, "There was a problem getting the winning reward!");

            emit Winner(msg.sender, reward);

            startGame();
        } 
    }

    function finishTheGame() external onlyOwner nonReentrant {
        isActive = false;

        (bool success, ) = payable(msg.sender).call{value : totalBalance}('');
        require(success, "There was a problem getting the withdraw!");

        totalBalance = 0;
        
        startGame();
    }
}