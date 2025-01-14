// scripts/interact.js

require('dotenv').config()
const { ethers } = require('hardhat')
const { expect } = require('chai')

async function main() {
  // 从环境变量获取合约地址
  const ERC20MockRCCTokenAddress = process.env.ERC20Mock_RCCToken_Address
  const RCCStakeProxyAddress = process.env.RCCStakeProxyAddress

  // 获取 ERC20Mock 合约实例
  const ERC20Mock = await ethers.getContractFactory('ERC20Mock')
  const rccToken = ERC20Mock.attach(ERC20MockRCCTokenAddress)

  // 获取 RCCStake 合约实例
  const RCCStake = await ethers.getContractFactory('RCCStake')
  const rccStake = RCCStake.attach(RCCStakeProxyAddress)

  console.log(rccToken.target, 'rccToken.target');
  console.log(rccStake.target, 'rccStake.target');

  // 查看 RCC 代币名称
  const name = await rccToken.name()
  console.log('RCC Token Name:', name)

  // 查看 RCC 代币符号
  const symbol = await rccToken.symbol()
  console.log('RCC Token Symbol:', symbol)

  // 查看 RCC 代币总供应量
  const totalSupply = await rccToken.totalSupply()
  console.log('Total Supply:', ethers.formatUnits(totalSupply, 18))

  // currentBlock = await ethers.provider.getBlockNumber() //
  // console.log(currentBlock, 'currentBlock')
  // // 查看 RCCStake 合约的开始和结束区块
  const startBlock = await rccStake.startBlock()
  console.log('RCCStake StartBlock:', startBlock)

  const endBlock = await rccStake.endBlock()
  console.log('RCCStake EndBlock:', endBlock)

  // 查看 RCCStake 合约的 RCCPerBlock
  const RCCPerBlock = await rccStake.RCCPerBlock()
  // console.log('RCCPerBlock:', ethers.formatUnits(RCCPerBlock, 18))
  console.log('RCCPerBlock:', `${ethers.formatEther(RCCPerBlock)} ETH`)

  // const adminRole = ethers.keccak256(ethers.toUtf8Bytes('admin_role'))
  // console.log(adminRole, 'adminRole')

  const [deployer] = await ethers.getSigners()
  console.log(deployer.address, 'deployer')

  // 验证 deployer 是否拥有 adminRole 权限
  const isAdmin_Role = await rccStake.hasRole(
    await rccStake.ADMIN_ROLE(),
    deployer.address
  )
  console.log(isAdmin_Role, 'isAdmin_Role')
  // 验证 deployer 是否拥有 DEFAULT_ADMIN_ROLE 权限
  const isDefault_Admin_Role = await rccStake.hasRole(
    await rccStake.DEFAULT_ADMIN_ROLE(),
    deployer.address
  )
  console.log(isDefault_Admin_Role, 'isDefault_Admin_Role')

  if (isAdmin_Role) {
    try {
      // // 添加第一个原生货币池
      // const addNativePoolTx = await rccStake.connect(deployer).addPool(
      //   ethers.ZeroAddress, // 使用 .ZeroAddress 确保传递 address(0)
      //   100, // poolWeight
      //   ethers.parseEther('0'), // minDepositAmount（根据合约逻辑）
      //   100, // unstakeLockedBlocks
      //   false // 不需要更新其他池
      // )
      // await addNativePoolTx.wait()
      // console.log(ethers.ZeroAddress, 'ethers.ZeroAddress')
      const poolLength = await rccStake.poolLength()
      console.log(poolLength, 'poolLength')

      // console.log(ERC20MockRCCTokenAddress, 'ERC20MockRCCTokenAddress');
      // console.log(RCCStakeProxyAddress, 'RCCStakeProxyAddress');
      
      // await rccToken.transfer(RCCStakeProxyAddress, ethers.parseEther("100000"));
      // console.log("RCC tokens transferred to RCCStake");

    } catch (error) {
      console.error(error, 'error')
    }
  } else {
    console.log(isAdmin_Role, '您没有权限执行！')
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
