import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import '@nomicfoundation/hardhat-ignition-ethers';
import '@nomicfoundation/hardhat-ethers';
import '@typechain/hardhat';
import dotenv from 'dotenv';
dotenv.config();

const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL || '';
const PRIVATE_KEY = process.env.PRIVATE_KEY || '';
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || '';

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{ version: '0.8.0' }, { version: '0.8.26' }, { version: '0.8.19' }],
  },
  defaultNetwork: 'hardhat',
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
      gas: 'auto',
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
  typechain: {
    outDir: 'typechain-types',
    target: 'ethers-v6',
  },
};

export default config;
