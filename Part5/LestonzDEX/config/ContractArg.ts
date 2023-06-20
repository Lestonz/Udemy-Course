import { ethers } from "hardhat";

const _rewardTokenAddress = "0x7146B574D020E8509FEe65853ebC275F57a72115";
const _period:any = 2592000;
const _prize:any = ethers.utils.parseUnits("387", 15);


const ContractArg = [
    _rewardTokenAddress,
    _period,
    _prize
]

export default ContractArg;