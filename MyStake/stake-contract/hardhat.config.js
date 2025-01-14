require('@nomicfoundation/hardhat-toolbox')
require('dotenv').config()
require('@openzeppelin/hardhat-upgrades')

/** @type import('hardhat/config').HardhatUserConfig */

// const { ProxyAgent, setGlobalDispatcher } = require('undici')
// const proxyAgent = new ProxyAgent('http://127.0.0.1:7897')
// setGlobalDispatcher(proxyAgent)

console.log(process.env.PRIVATE_KEY)
module.exports = {
  mocha: {
    timeout: 300000 //设置mocha的超时时间为300秒，解决集成测试时间不够问题
  },
  solidity: {
    version: '0.8.24',
    settings: {
      optimizer: {
        enabled: false,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {},
    sepolia: {
      url:
        'https://eth-sepolia.g.alchemy.com/v2/' + process.env.ALCHEMY_API_KEY,
      accounts: [process.env.PRIVATE_KEY],
      chainId: 11155111
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  }
  // sourcify: {
  //   enabled: true
  // }
}
