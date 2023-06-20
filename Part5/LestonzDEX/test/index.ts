import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { LestonzDex, LestonzDex__factory, LestonzToken, LestonzToken__factory } from "../typechain-types";
describe("LestonzDEX", function () {
    let rewardToken: any;
    let dex: any;
    let owner: any;
    let trader1: any;
    let trader2: any;

    const _period:any = 2592000;
    const _prize:any = ethers.utils.parseUnits("387", 15);

    before("Contracts deployed", async function () {
        [owner, trader1, trader2] = await ethers.getSigners();

        const lestonzTokenFactory:LestonzToken__factory = await ethers.getContractFactory("LestonzToken", owner);
        rewardToken = (await lestonzTokenFactory.deploy()) as LestonzToken;
        await rewardToken.deployed();

        const dexFactory:LestonzDex__factory = await ethers.getContractFactory("LestonzDex");
        dex = (await dexFactory.deploy(rewardToken.address, _period, _prize));
        await dex.deployed();
    })

    it("Reward Token Contract deployed",async () => {
        expect(rewardToken.address).to.not.equal(0);
    })

    it(" Lestonz DEX Contract deployed",async () => {
        expect(dex.address).to.not.equal(0);
    })

    it("Is Reward Token Supply correct?",async () => {
        expect(await rewardToken.connect(owner).balanceOf(owner.address)).to.equal(ethers.utils.parseUnits("1000000", 18));
    })

    it("Transfer control for trader1", async () => {
        await rewardToken.connect(owner).transfer(trader1.address, ethers.utils.parseUnits("1000", 18));
        expect(await rewardToken.balanceOf(trader1.address)).to.equal(ethers.utils.parseUnits("1000", 18));
    })

    it("Transfer control for trader2", async () => {
        await rewardToken.connect(owner).transfer(trader2.address, ethers.utils.parseUnits("1000", 18));
        expect(await rewardToken.balanceOf(trader2.address)).to.equal(ethers.utils.parseUnits("1000", 18));
    })

    it("Transfer control for DEX", async () => {
        await rewardToken.connect(owner).transfer(dex.address, ethers.utils.parseUnits("100000", 18));
        expect(await rewardToken.balanceOf(dex.address)).to.equal(ethers.utils.parseUnits("100000", 18));
    })

    it("Giving Approve", async () => {
        await rewardToken.connect(owner).approve(dex.address,ethers.utils.parseUnits("100000", 18) );
        await rewardToken.connect(trader1).approve(dex.address,ethers.utils.parseUnits("1000", 18) );
        await rewardToken.connect(trader2).approve(dex.address,ethers.utils.parseUnits("1000", 18) );
    })

    it("Check to Approve", async () => {
        let allowances = [
            await rewardToken.allowance(trader1.address, dex.address),
            await rewardToken.allowance(trader2.address, dex.address)
        ];

        expect(allowances[0]).to.be.equal(ethers.utils.parseUnits("1000", 18));
        expect(allowances[0]).to.be.equal(allowances[1]);
    })

    it("Open Position", async () => {
        await dex.connect(trader1).openPosition(ethers.utils.parseUnits("300", 18));
        await dex.connect(trader2).openPosition(ethers.utils.parseUnits("225", 18));

        const cumulativeMarketVolume = await dex.cumulativeMarketVolume();

        expect(cumulativeMarketVolume).to.equal(ethers.utils.parseUnits("525", 18));
    })

    it("Close position", async () => {
        const cumulativeMarketVolumeBefore = await dex.cumulativeMarketVolume();
        const trader1BalanceBefore = await rewardToken.balanceOf(trader1.address);
        const trader2BalanceBefore = await rewardToken.balanceOf(trader2.address);

        await dex.connect(trader1).closePosition(ethers.utils.parseUnits("100", 18));
        await dex.connect(trader2).closePosition(ethers.utils.parseUnits("150", 18));

        const cumulativeMarketVolumeAfter = await dex.cumulativeMarketVolume();
        const trader1BalanceAfter = await rewardToken.balanceOf(trader1.address);
        const trader2BalanceAfter = await rewardToken.balanceOf(trader2.address);

        expect(cumulativeMarketVolumeBefore).to.not.equal(cumulativeMarketVolumeAfter);
        expect(trader1BalanceBefore).to.not.equal(trader1BalanceAfter);
        expect(trader2BalanceBefore).to.not.equal(trader2BalanceAfter);

    } )

    it("Request Reward Token", async () => {
        const trader1BalanceBefore = await rewardToken.balanceOf(trader1.address);
        const trader2BalanceBefore = await rewardToken.balanceOf(trader2.address);

        const totalPrizeTrader1Before = await dex.connect(trader1).totalPrize(trader1.address);
        const totalPrizeTrader2Before = await dex.connect(trader2).totalPrize(trader2.address);

        const cumulativeMarketVolumeBefore = await dex.cumulativeMarketVolume();

        await dex.connect(trader1).rewardWithdraw();
        await dex.connect(trader2).rewardWithdraw();

        const trader1BalanceAfter = await rewardToken.balanceOf(trader1.address);
        const trader2BalanceAfter = await rewardToken.balanceOf(trader2.address);

        const totalPrizeTrader1After = await dex.connect(trader1).totalPrize(trader1.address);
        const totalPrizeTrader2After = await dex.connect(trader2).totalPrize(trader2.address);

        const cumulativeMarketVolumeAfter = await dex.cumulativeMarketVolume();

        expect(trader1BalanceBefore).to.not.equal(trader1BalanceAfter);
        expect(trader2BalanceBefore).to.not.equal(trader2BalanceAfter);

        expect(totalPrizeTrader1Before).to.not.equal(totalPrizeTrader1After);
        expect(totalPrizeTrader2Before).to.not.equal(totalPrizeTrader2After);

        expect(cumulativeMarketVolumeBefore).to.equal(cumulativeMarketVolumeAfter);
    } )
});
