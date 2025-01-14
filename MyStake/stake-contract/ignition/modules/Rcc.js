const { buildModule } = require('@nomicfoundation/hardhat-ignition/modules')
const { ethers, upgrades } = require('hardhat')
module.exports = buildModule('CLMTokenModule', (m) => {
  console.log('Deploying reward token (ERC20)...')
  // 部署 RccToken 合约，传入初始持有者地址作为参数
  const name = m.getParameter('name', 'CLMToken')
  const symbol = m.getParameter('symbol', 'CLM')
  const initialSupply = m.getParameter(
    'initialSupply',
    ethers.parseEther('1000000')
  )

  const clmToken = m.contract('CLMToken', [name, symbol, initialSupply], {
    afterDeploy: async () => {
      await clmToken.initialize(name, symbol, initialSupply)
      console.log('clmToken initialized with:', {
        name,
        symbol,
        initialSupply
      })
    }
  })
  console.log(clmToken);
  return { clmToken }
})

// .deploy("Mock IERC20 token names ERC20AAA", "ercAAA", 200)

// // 部署 RCC 代币合约
// RCC = await ethers.getContractFactory("ERC20Mock");
// console.log("Deploying ERC20Mock contract...");
// rcc = await RCC.deploy("RCC Token", "RCC", 18, ethers.parseEther("1000000"));
// // 等待交易确认并获取地址
// await rcc.deploymentTransaction().wait(); // 确保部署交易完成
// // 获取部署后的合约地址
// const rccAddress = await rcc.getAddress(); // 使用 await 解析 Promise
// console.log(`ERC20Mock deployed at: ${rccAddress}`);

// // 部署 RCCStake 合约
// RCCStake = await ethers.getContractFactory("RCCStake");
// console.log("Deploying RCCStake contract...");
// [owner, addr1, addr2] = await ethers.getSigners();
// rccStake = await RCCStake.deploy();
// await rccStake.deploymentTransaction().wait(); // 确保部署交易完成
// const rccStakeAddress = await rcc.getAddress(); // 使用 await 解析 Promise
// console.log(`RCCStake deployed at: ${rccStakeAddress}`);

// try {
//     await rccStake.initialize(rccAddress, 0, 1000000, ethers.parseEther("1"));
//     console.log("RCCStake initialized.");
// } catch (error) {
//     console.error("Initialization failed:", error);
// }
