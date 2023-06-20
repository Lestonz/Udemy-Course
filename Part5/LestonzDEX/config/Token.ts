import { ethers } from "hardhat";
const _owner = "0x8a53D9e124Aca71eB25759D736459cF41C136d2B";
const _supply:any = ethers.utils.parseUnits("1000000", 18);

const TokenArg = [
    _owner,
    _supply
]

export default TokenArg;