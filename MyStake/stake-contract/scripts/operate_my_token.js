require('dotenv').config()
const { ethers } = require('hardhat')
async function main() {
  try {
    // 从环境变量获取合约地址
    const ERC20MockLMTokenAddress = process.env.ERC20Mock_LMToken_Address
    const RCCStakeProxyAddress = process.env.RCCStakeProxyAddress

    // 获取 ERC20Mock 合约实例
    const ERC20Mock = await ethers.getContractFactory('ERC20Mock')
    const lmToken = ERC20Mock.attach(ERC20MockLMTokenAddress)

    // 获取 RCCStake 合约实例
    const RCCStake = await ethers.getContractFactory('RCCStake')
    const rccStake = RCCStake.attach(RCCStakeProxyAddress)
    console.log(rccStake.target, 'rccStake.target')
    console.log(lmToken.target, 'lmToken.target')

    const [deployer] = await ethers.getSigners()

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
      // 查看 LMT 代币名称
      const name = await lmToken.name()
      console.log('LM Token Name:', name)

      // 查看 LMT 代币符号
      const symbol = await lmToken.symbol()
      console.log('LM Token Symbol:', symbol)

      // 查看 LMT 代币总供应量
      const totalSupply = await lmToken.totalSupply()
      console.log('Total Supply:', `${ethers.formatEther(totalSupply)} ETH`)

      // Admin 添加一个新的质押池
      const addPoolTx = await rccStake
        .connect(deployer)
        .addPool(lmToken.target, 100, ethers.parseEther('10'), 100, true)
      await addPoolTx.wait()
      console.log(addPoolTx, 'addPoolTx')
      // await expect(addPoolTx).to.emit(rccStake, 'AddPool')
      const poolLength = await rccStake.poolLength()
      console.log(poolLength, 'poolLength')
    } else {
      console.log('deployer is not admin')
    }
  } catch (error) {
    console.error(error, 'error')
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
