const { ethers, upgrades } = require('hardhat')

async function main() {
  //  部署获取到的Clm Token 地址
  const ClmToken = '0x5FbDB2315678afecb367f032d93F642f64180aa3'
  // 质押起始区块高度,可以去sepolia上面读取最新的区块高度
  const startBlock = 7214403
  // 质押结束的区块高度,sepolia 出块时间是12s,想要质押合约运行x秒,那么endBlock = startBlock+x/12
  const endBlock = 10214403
  // 每个区块质押多少 CLM token的数量
  const clmPerBlock = '20000000000000000'
  const Stake = await hre.ethers.getContractFactory('CLMStake')
  console.log('Deploying CLMStake...')
  const s = await upgrades.deployProxy(
    Stake,
    [ClmToken, startBlock, endBlock, clmPerBlock],
    { initializer: 'initialize' }
  )
  //await box.deployed();
  console.log('Box deployed to:', await s.getAddress())
}

main()
