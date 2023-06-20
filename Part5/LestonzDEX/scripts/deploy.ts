import { ethers } from "hardhat";
import { LestonzDex, LestonzDex__factory, LestonzToken, LestonzToken__factory } from "../typechain-types";
async function main() {
  const _period:any = 2592000;
  const _prize:any = ethers.utils.parseUnits("387", 15);

  console.log("Reward Token are deploying...");
  const rewardToken:LestonzToken__factory = await ethers.getContractFactory("LestonzToken");
  const RewardToken:LestonzToken = await rewardToken.deploy() as LestonzToken;
  await RewardToken.deployed();

  console.log("Your Reward Token Address: ", RewardToken.address);

  console.log(" Lestonz DEX are deploying...");

  const dex:LestonzDex__factory = await ethers.getContractFactory("LestonzDex");
  const Dex:LestonzDex = await dex.deploy(RewardToken.address, _period, _prize) as LestonzDex;
  await Dex.deployed();

  console.log("Lestonz DEX contract address: ", Dex.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
