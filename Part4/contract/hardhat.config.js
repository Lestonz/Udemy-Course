require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");

/** @type import('hardhat/config').HardhatUserConfig */
const API = "YOUR_ETHERSCAN_ID";
const DEFAULT_GAS =1;

module.exports = {
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
