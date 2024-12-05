const { buildModule } = require('@nomicfoundation/hardhat-ignition/modules')
const { ethers, upgrades } = require('hardhat')

module.exports = buildModule('CLMTokenModule', (m) => {
  // 部署 ClmToken 合约，传入初始持有者地址作为参数
  const clmToken = m.contract('CLMToken');
  return { clmToken }
})