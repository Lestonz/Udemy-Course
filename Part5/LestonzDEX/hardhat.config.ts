import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const API:any = "YOUR_ETHERSCAN_ID";
const DEFAULT_GAS: number = 1 ;

const config: HardhatUserConfig = {
  solidity: "0.8.7",
  networks: {
    local: {
      url: "http://127.0.0.1:8545"
    },
    truffle : {
      url: "http://localhost:24012/rpc",
      timeout: 600000,
      gasMultiplier: DEFAULT_GAS,
    }
  },
  etherscan: {
    apiKey: {
      // ethereum
      goerli: API,
      sepolia: API,
      mainnet: API,
    }
  }
};

export default config;
