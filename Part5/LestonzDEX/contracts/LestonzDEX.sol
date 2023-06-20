// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LestonzDex {

    // Variables
    address public owner;
    address public rewardToken;

    uint public period; // time
    uint public prize;

    uint public timeStart;
    uint public lastRewardTime;
    uint public cumulativeMarketVolume;
    // cumulative: 100$ deposit for staking and than 50$ withdraw => cumulative Market Volume is equal to 150$

    address[] internal traders;

    // Mappings
    mapping(address => uint) public cumulativeTraderVolume;
    mapping(address => uint) public traderVolume;
    mapping(address => uint) public totalPrize;

    // Events
    event openedPosition(address indexed trader, uint token);
    event closedPosition(address indexed trader, uint token);
    event prizeRequested(address indexed trader, uint token);

    // Constructor
    constructor(address _rewardToken, uint _period, uint _prize) {
        owner = msg.sender;
        rewardToken = _rewardToken;
        period = _period;
        prize =_prize;
        timeStart = block.timestamp;
        lastRewardTime = block.timestamp -1;
    }
    
    // Time Controller  
    function periodController() internal {
        if(block.timestamp >= timeStart + period) {
            uint modPeriod = block.timestamp % period;
            timeStart = block.timestamp - modPeriod;
            lastRewardTime = block.timestamp - 1;
            traders = new address[](0); // reset to array
            cumulativeTraderVolume[msg.sender] = 0;
            cumulativeMarketVolume = 0;
        }
    }

    // Calculate to Prize or Reward
    function rewardCalculate(uint _time, address _trader) internal {
        totalPrize[_trader] += ((_time * cumulativeTraderVolume[_trader] * prize ) / cumulativeMarketVolume);
    }

    // open Position
    function openPosition( uint _token) external payable {
        require(_token > 0, "Token should be greater than 0.");
        ERC20(rewardToken).approve(address(this), _token);
        require( ERC20(rewardToken).balanceOf(msg.sender) >= _token, "Insufficient balance!");
        require( ERC20(rewardToken).allowance(msg.sender, address(this)) >= _token, "You must aoorove enough for this position!");
        require( ERC20(rewardToken).transferFrom(msg.sender, address(this), _token), "Someting is error from transfer.");

        periodController();

        // if you are first time entry
        if (cumulativeTraderVolume[msg.sender] == 0) {
            traders.push(msg.sender);
        }

        uint time = block.timestamp - lastRewardTime;

        traderVolume[msg.sender] += _token;
        cumulativeTraderVolume[msg.sender] += _token;

        cumulativeMarketVolume += _token;

        emit openedPosition(msg.sender, _token);

        rewardCalculate(time, msg.sender);
        lastRewardTime = block.timestamp;
    }

    // Close Positions
    function closePosition( uint _token) external {
        require(_token > 0, "Token should be greater than 0.");
        require(traderVolume[msg.sender] >= _token, "Token amount is wrong");  
        require(ERC20(rewardToken).transfer(msg.sender, _token), "Someting is error from transfer.");

        periodController();

        // if you are first time entry
        if (cumulativeTraderVolume[msg.sender] == 0) {
            traders.push(msg.sender);
        }

        uint time = block.timestamp - lastRewardTime;

        traderVolume[msg.sender] -= _token;
        cumulativeTraderVolume[msg.sender]  += _token;
        cumulativeMarketVolume += _token;

        emit closedPosition(msg.sender, _token);

        rewardCalculate(time, msg.sender);
        lastRewardTime = block.timestamp;
    }

    // Reward Request
    function rewardWithdraw() external payable {
        require(totalPrize[msg.sender] >= 0, "It should be greater than 0!");
        require(ERC20(rewardToken).transfer(msg.sender, totalPrize[msg.sender]), "Someting is error from transfer.");

        emit prizeRequested(msg.sender,totalPrize[msg.sender] );
        totalPrize[msg.sender] = 0;
    }

    // Period see
    function periodLeftTime() external view returns (uint) {
        return (timeStart + period) - block.timestamp;
    }

    // See to Total Prize Amount
    function totalPrizeToken() external view returns (uint) { 
        return ERC20(rewardToken).balanceOf(address(this));
    }
}