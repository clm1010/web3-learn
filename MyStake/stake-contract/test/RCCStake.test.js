const { ethers, upgrades } = require('hardhat')
const { expect } = require('chai')

// RCCStake 部署测试
describe('RCCStake Contract', function () {
  let RCCToken
  let rccToken
  let RCCStake
  let rccStake
  let deployer, admin, user1, user2
  const startBlockPosition = 10 // 质押开始于 10 个区块后
  const endBlockPosition = 1000 // 任意结束区块
  const RCCPerBlock = ethers.parseEther('10') // 每区块 10 RCC

  // beforeEach 确实会在每个测试用例（it 块）运行之前执行一次
  beforeEach(async function () {
    ;[deployer, admin, user1, user2, ...addrs] = await ethers.getSigners()
    console.log(deployer.address, 'deployer address')
    // 获取每个签名者的地址
    user1Address = await user1.getAddress()
    user2Address = await user2.getAddress()

    // 部署 ERC20Mock RCCToken
    RCCToken = await ethers.getContractFactory('ERC20Mock')
    rccToken = await RCCToken.deploy(
      'RCC Token',
      'RCC',
      18,
      ethers.parseEther('1000000')
    )
    await rccToken.waitForDeployment()
    console.log(`ERC20Mock 部署地址在: ${rccToken.target}`)

    // 部署 RCCStake 合约
    currentBlock = await ethers.provider.getBlockNumber() // 获取当前区块号

    RCCStake = await ethers.getContractFactory('RCCStake')
    rccStake = await upgrades.deployProxy(
      RCCStake,
      [
        rccToken.target,
        currentBlock + startBlockPosition,
        currentBlock + endBlockPosition,
        RCCPerBlock
      ],
      { initializer: 'initialize' }
    )
    await rccStake.waitForDeployment()

    // 授予 admin 权限
    const adminRole = ethers.keccak256(ethers.toUtf8Bytes('admin_role'))

    await rccStake.grantRole(adminRole, admin.address)
    // 判断是否拥有管理员角色
    expect(
      await rccStake.hasRole(await rccStake.ADMIN_ROLE(), admin.address)
    ).to.be.true
    // 判断是否拥有默认管理员角色
    expect(
      await rccStake.hasRole(await rccStake.DEFAULT_ADMIN_ROLE(), admin.address)
    ).to.be.false
    console.log('Admin role granted to:', admin.address)

    // 授予 upgradeRole 权限
    // const upgradeRole = ethers.keccak256(ethers.toUtf8Bytes('upgrade_role'))
    // await rccStake.grantRole(upgradeRole, admin.address)
    // expect(
    //   await rccStake.hasRole(await rccStake.UPGRADE_ROLE(), admin.address)
    // ).to.be.true

    // 添加第一个原生货币池
    const addNativePoolTx = await rccStake.connect(admin).addPool(
      ethers.ZeroAddress, // 使用 .ZeroAddress 确保传递 address(0)
      100, // poolWeight
      ethers.parseEther('0'), // minDepositAmount（根据合约逻辑）
      100, // unstakeLockedBlocks
      false // 不需要更新其他池
    )
    await addNativePoolTx.wait()
    console.log(ethers.ZeroAddress, 'ethers.ZeroAddress')

    // 分发 RCC 代币给 RCCStake 合约用于奖励
    await rccToken.transfer(rccStake.target, ethers.parseEther('100000'))
    console.log('RCC代币分发到RCCStake')
  })

  // 初始化功能验证
  describe('Initialization', function () {
    // 是否正确的设置 RCC令牌，令牌名称，符号，小数，总供应量和地址
    it('Should set the correct RCC token , Token name, symbol, decimals ,total supply and  address', async function () {
      expect(await rccStake.RCC()).to.equal(rccToken.target)
      // 检查代币合约中定义的代币名称，符号和精确度是否有误
      expect(await rccToken.name()).to.equal('RCC Token')
      expect(await rccToken.symbol()).to.equal('RCC')
      expect(await rccToken.decimals()).to.equal(18)
      expect(await rccToken.totalSupply()).to.equal(
        ethers.parseEther('1000000')
      )
    })

    // 是否正确的设置开始和结束区块
    it('Should set the correct start and end block position', async function () {
      expect(await rccStake.startBlock()).to.equal(
        BigInt(currentBlock + startBlockPosition)
      )
      expect(await rccStake.endBlock()).to.equal(
        BigInt(currentBlock + endBlockPosition)
      )
    })

    // 是否正确的设置 RCCPerBlock
    it('Should set the correct RCCPerBlock', async function () {
      expect(await rccStake.RCCPerBlock()).to.equal(RCCPerBlock)
    })
  })

  // 管理员角色和非管理员角色功能验证
  describe('Admin and Non-Admin Functions', function () {
    // 管理员设置 RCC 代币地址
    it('Admin can set RCC token address', async function () {
      const ftkToken = await RCCToken.deploy(
        'First token',
        'FTK',
        18,
        ethers.parseEther('1000000')
      )
      await ftkToken.waitForDeployment()

      const setRCCTx = await rccStake.connect(admin).setRCC(ftkToken.target)
      await expect(setRCCTx)
        .to.emit(rccStake, 'SetRCC')
        .withArgs(ftkToken.target)
      expect(await rccStake.RCC()).to.equal(ftkToken.target)
    })

    // 非管理员不能设置 RCC 代币地址
    it('Non-admin cannot set RCC token address', async function () {
      await expect(rccStake.connect(user1).setRCC(user1Address)).to.be.reverted

      // rejectedWith(
      //   'AccessControl: account ' + user1Address + ' is missing role'
      // )
    })

    // 管理员可以暂停和恢复取款功能
    it('Admin can pause and unpause withdrawal', async function () {
      // 管理员可以调用 pauseWithdraw 和 unpauseWithdraw 来暂停和恢复取款功能
      // 分别触发 PauseWithdraw 和 UnpauseWithdraw 事件
      // 并正确更新状态变量 withdrawPaused
      const pauseTx = await rccStake.connect(admin).pauseWithdraw()
      await expect(pauseTx).to.emit(rccStake, 'PauseWithdraw')
      expect(await rccStake.withdrawPaused()).to.equal(true)

      const unpauseTx = await rccStake.connect(admin).unpauseWithdraw()
      await expect(unpauseTx).to.emit(rccStake, 'UnpauseWithdraw')
      expect(await rccStake.withdrawPaused()).to.equal(false)
    })

    // 管理员可以暂停和恢复领取奖励
    it('Admin can pause and unpause claim', async function () {
      const pauseTx = await rccStake.connect(admin).pauseClaim()
      await expect(pauseTx).to.emit(rccStake, 'PauseClaim')

      expect(await rccStake.claimPaused()).to.equal(true)

      const unpauseTx = await rccStake.connect(admin).unpauseClaim()
      await expect(unpauseTx).to.emit(rccStake, 'UnpauseClaim')

      expect(await rccStake.claimPaused()).to.equal(false)
    })

    // 管理员可以添加新的质押池
    it('Admin can add a new pool', async function () {
      const pledgeToken = await RCCToken.deploy(
        'Pledge Token',
        'PLE',
        18,
        ethers.parseEther('1000000')
      )

      pledgeToken.waitForDeployment()

      const addPoolTx = await rccStake
        .connect(admin)
        .addPool(pledgeToken.target, 100, ethers.parseEther('10'), 100, true)
      await addPoolTx.wait()
      await expect(addPoolTx).to.emit(rccStake, 'AddPool')

      const poolLength = await rccStake.poolLength()
      // console.log(poolLength, 'poolLength1')
      expect(poolLength).to.equal(2)
    })
  })

  // 测试用户功能
  describe('User Functions', function () {
    let stkToken
    beforeEach(async function () {
      stkToken = await RCCToken.deploy(
        'Sign Token',
        'STK',
        18,
        ethers.parseEther('1000000')
      )
      await stkToken.waitForDeployment()
      console.log(stkToken.target, 'stkToken.target')

      // Admin 添加一个新的质押池
      const addPoolTx = await rccStake
        .connect(admin)
        .addPool(stkToken.target, 100, ethers.parseEther('10'), 100, true)
      await addPoolTx.wait()
      await expect(addPoolTx).to.emit(rccStake, 'AddPool')

      const poolLength = await rccStake.poolLength()
      console.log(poolLength, 'poolLength')
      // console.log(addPoolTx, 'addPoolTx')

      // 为 user1 和 user2 铸造 stkTokens
      await stkToken.mint(user1Address, ethers.parseEther('1000'))
      await stkToken.mint(user2Address, ethers.parseEther('1000'))
      console.log(
        `\tUser1: ${user1Address}\n\tUser2: ${user2Address}\n\t铸造了 1000 个 stkToken`
      )

      // 用户批准，RCCStake合约，可以转移其代币
      await stkToken
        .connect(user1)
        .approve(rccStake.target, ethers.parseEther('1000'))
      await stkToken
        .connect(user2)
        .approve(rccStake.target, ethers.parseEther('1000'))
      console.log('批准，RCCStake合约，可以转移其代币')
    })

    // 用户可以存放 Sign tokens
    it('User can deposit Sign tokens', async function () {
      const depositTx = await rccStake
        .connect(user1)
        .deposit(1, ethers.parseEther('100'))
      await expect(depositTx).to.emit(rccStake, 'Deposit')

      // 用户质押的代币数量
      const userInfo = await rccStake.user(1, user1Address)
      expect(userInfo.stAmount).to.equal(ethers.parseEther('100'))
    })

    // 用户不能存入低于 最小质押 的金额
    it('User cannot deposit below minDepositAmount', async function () {
      await expect(
        rccStake.connect(user1).deposit(1, ethers.parseEther('5'))
        // 断言事务是否因特定的自定义错误而回退
      ).to.be.revertedWithCustomError(RCCStake, 'InvalidParameters')
    })

    // 用户可以在锁定期后要求解除锁定和提现
    it('User can request unstake and withdraw after lock period', async function () {
      // 用户存款
      // 调用 deposit 函数，向池子编号为 1 的质押池存入 100 个代币
      const depositTx = await rccStake
        .connect(user1)
        .deposit(1, ethers.parseEther('100'))
      // 等待交易被矿工打包并确认
      await depositTx.wait()
      await expect(depositTx).to.emit(rccStake, 'Deposit')

      // 增加若干区块。模拟时间流逝
      for (let i = 0; i < 150; i++) {
        // 调用以太坊虚拟机（EVM）来挖出一个新的区块
        await ethers.provider.send('evm_mine', [])
      }

      // 用户请求取款。
      // 用户 user1 调用 unstake 函数，从池子编号 1 的质押池中请求解除 50 个代币的质押
      const unstakeTx = await rccStake
        .connect(user1)
        .unstake(1, ethers.parseEther('50'))
      // 等待交易被矿工打包并确认
      await unstakeTx.wait()
      // 使用 Chai 的断言库验证交易是否正确触发了预期的事件
      await expect(unstakeTx)
        .to.emit(rccStake, 'RequestUnstake')
        // 期望事件的参数为 user1 的地址、池子编号 1 和解除质押的数量 50
        .withArgs(user1Address, 1, ethers.parseEther('50'))

      // 增加更多区块以超过锁定期
      for (let i = 0; i < 100; i++) {
        await ethers.provider.send('evm_mine', [])
      }

      // 用户提取取款
      const withdrawTx = await rccStake.connect(user1).withdraw(1)
      const currentBlock = await ethers.provider.getBlockNumber()
      await withdrawTx.wait()
      await expect(withdrawTx)
        .to.emit(rccStake, 'Withdraw')
        .withArgs(user1Address, 1, ethers.parseEther('50'), currentBlock)

      // 验证用户的质押信息是否正确更新
      // 调用合约的 user 函数，获取用户 user1 在池子编号 1 中的质押信息
      // mapping(uint256 => mapping(address => UserInfo)) public user;
      // function user(uint256 poolId, address userAddress) external view returns (UserInfo memory);
      const userInfo = await rccStake.user(1, user1Address)
      expect(userInfo.stAmount).to.equal(ethers.parseEther('50'))
      console.log(
        `${ethers.formatEther(userInfo.stAmount)} ETH `,
        'userInfo.stAmount'
      )
    })

    // 用户可以申请RCC奖励
    it('User can claim RCC rewards', async function () {
      // 用户存款
      const depositTx = await rccStake
        .connect(user2)
        .deposit(1, ethers.parseEther('100'))
      await depositTx.wait()

      // 增加若干区块以生成奖励
      for (let i = 0; i < 50; i++) {
        await ethers.provider.send('evm_mine', [])
      }

      // 用户领取奖励
      const claimTx = await rccStake.connect(user2).claim(1)
      await expect(claimTx).to.emit(rccStake, 'Claim')

      // 用户领取奖励
      const userRCCBalance = await rccToken.balanceOf(user2Address)
      // 断言用户的 RCC 代币余额大于 0
      expect(userRCCBalance).to.be.gt(ethers.parseEther('0'))
    })

    // 当申请暂停时，用户不能申请奖励
    it('User cannot claim rewards when claim is paused', async function () {
      // 用户存款
      const depositTx = await rccStake
        .connect(user1)
        .deposit(1, ethers.parseEther('100'))
      await depositTx.wait()

      // 管理员暂停领取
      const pauseClaimTx = await rccStake.connect(admin).pauseClaim()
      await pauseClaimTx.wait()

      // 领取奖励
      await expect(
        rccStake.connect(user1).claim(1)
        // 期望合约调用会以回退的方式失败，并且错误信息包含 "ClaimPaused"
      ).to.be.revertedWithCustomError(rccStake, 'ClaimPaused')
    })

    // 暂停提现时，用户无法提现
    it('User cannot withdraw when withdrawal is paused', async function () {
      // 用户存款
      const depositTx = await rccStake
        .connect(user1)
        .deposit(1, ethers.parseEther('100'))
      await depositTx.wait()

      // 用户请求取款
      const unstakeTx = await rccStake
        .connect(user1)
        .unstake(1, ethers.parseEther('50'))
      await unstakeTx.wait()

      // 管理员暂停取款
      const pauseWithdrawTx = await rccStake.connect(admin).pauseWithdraw()
      await pauseWithdrawTx.wait()

      // 增加足够的区块以超过锁定期
      for (let i = 0; i < 150; i++) {
        await ethers.provider.send('evm_mine', [])
      }

      await expect(
        rccStake.connect(user1).withdraw(1)
      ).to.be.revertedWithCustomError(rccStake, 'WithdrawPaused')
    })

    // 多个用户可以独立交互
    it('Multiple users can interact independently', async function () {
      // 用户1存款
      const depositUser1Tx = await rccStake
        .connect(user1)
        .deposit(1, ethers.parseEther('100'))
      await depositUser1Tx.wait()

      // 用户2存款
      const depositUser2Tx = await rccStake
        .connect(user2)
        .deposit(1, ethers.parseEther('200'))
      await depositUser2Tx.wait()

      // 增加若干区块
      for (let i = 0; i < 100; i++) {
        await ethers.provider.send('evm_mine', [])
      }

      // 用户1领取奖励
      const claimUser1Tx = await rccStake.connect(user1).claim(1)
      await expect(claimUser1Tx).to.emit(rccStake, 'Claim')
      const user1RCC = await rccToken.balanceOf(user1Address)
      expect(user1RCC).to.be.gt(ethers.parseEther('0'))

      // 用户2领取奖励
      const claimUser2Tx = await rccStake.connect(user2).claim(1)
      await expect(claimUser2Tx).to.emit(rccStake, 'Claim')
      const user2RCC = await rccToken.balanceOf(user2Address)
      expect(user2RCC).to.be.gt(user1RCC)
    })
  })

  // 测试边界case和安全性
  describe('Edge cases and security', function () {
    // 无效的质押代币地址
    it('Cannot add a pool with invalid signing token address', async function () {
      await expect(
        rccStake.connect(admin).addPool(
          ethers.ZeroAddress, // ethers.ZeroAddress
          100,
          ethers.parseEther('10'),
          100,
          true
        )
      ).to.be.revertedWithCustomError(rccStake, 'InvalidStakingTokenAddress')
    })

    // startBlock不能大于endBlock
    it('Cannot set startBlock greater than endBlock', async function () {
      const currentBlock = await ethers.provider.getBlockNumber()
      await expect(
        rccStake.connect(admin).setStartBlock(currentBlock + 2000)
      ).to.be.revertedWithCustomError(
        rccStake,
        'StartBlockMustBeSmallerThanEndBlock'
      )
    })

    // endBlock不能小于startBlock
    it('Cannot set endBlock less than startBlock', async function () {
      const currentBlock = await ethers.provider.getBlockNumber()
      await expect(
        rccStake.connect(admin).setEndBlock(currentBlock - 10)
      ).to.be.revertedWithCustomError(
        rccStake,
        'StartBlockMustBeSmallerThanEndBlock'
      )
    })
  })
})
