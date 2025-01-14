// scripts/deploy.js

const { ethers, upgrades } = require('hardhat')
async function main() {
  // 1. 部署 ERC20Mock 合约作为 RCC 代币（仅用于本地测试）
  console.log('部署 ERC20Mock (ERC20)...')
  const ERC20Mock = await ethers.getContractFactory('ERC20Mock')
  const rcc = await ERC20Mock.deploy(
    'RCC Token',
    'RCC',
    18,
    ethers.parseEther('1000000')
  )
  await rcc.waitForDeployment() // 等待部署完成,确保部署交易完成
  // const rccAddress = await rcc.getAddress(); // 使用 await 解析 Promise
  console.log(`ERC20Mock RCC Token 部署地址在: ${rcc.target}`)
  console.log(ethers.parseEther('1000000'))

  // 2. 部署 RCCStake 合约
  console.log('部署 RCCStake 合约...')
  const currentBlock = await ethers.provider.getBlockNumber() // // 获取当前区块号
  const startBlock = currentBlock + 10 // 质押开始于 10 个区块后
  const endBlock = startBlock + 100000 // 任意结束区块
  const RCCPerBlock = ethers.parseUnits('10', 18) // 每区块 10 RCC

  console.log(currentBlock, 'currentBlock')
  console.log(startBlock, 'startBlock')
  console.log(endBlock, 'endBlock')
  console.log(`${ethers.formatEther(RCCPerBlock)} ETH`, 'RCCPerBlock')

  // 获取 RCCStake 合约工厂
  const RCCStake = await ethers.getContractFactory('RCCStake')
  console.log('部署RCCStake可升级代理合约并初始化合约...')
  // 部署可升级代理合约
  // 用于转发调用到逻辑合约
  const rccStake = await upgrades.deployProxy(
    RCCStake,
    [rcc.target, startBlock, endBlock, RCCPerBlock],
    { initializer: 'initialize' }
  )
  await rccStake.waitForDeployment() // 等待部署完成,确保部署交易完成
  console.log(`RCCStake 部署地址在: ${rccStake.target}`)

  // 可选
  // 逻辑合约，这是实际包含业务逻辑的合约，也就RCCStake实际部署的合约地址
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    rccStake.target
  )
  console.log(`RCCStake 代理逻辑合约地址在: ${implementationAddress}`)
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error, 'error')
    process.exit(1)
  })
