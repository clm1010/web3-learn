import 'dotenv/config'

import { ethers } from 'ethers'
// 1. 创建HD钱包
console.log('\n1. 创建HD钱包')
// 通过助记词生成HD钱包
const mnemonic = `air organ twist rule prison symptom jazz cheap rather dizzy verb glare jeans orbit weapon universe require tired sing casino business anxiety seminar hunt`
const hdNode = ethers.HDNodeWallet.fromPhrase(mnemonic)
console.log(hdNode)

// 2. 获得20个钱包的地址
console.log('\n2. 通过HD钱包派生20个钱包')
const numWallet = 20
// 派生路径：m / purpose' / coin_type' / account' / change / address_index
// 我们只需要切换最后一位address_index，就可以从hdNode派生出新钱包

// const ethers = require("ethers");
// const path0 = "44'/60'/0'/0/0";
// const phrase = "word word word word word word word word word word word word";
// const mnemonic = ethers.Mnemonic.fromPhrase(phrase);
// const wallet0 = ethers.HDNodeWallet.fromMnemonic(mnemonic, path0);
// console.log(wallet0.path); // output: m/44'/60'/0'/0/0

// const path1 = "44'/60'/0'/0/1";
// const wallet1 = wallet0.derivePath(path1);
// console.log(wallet1.path); // output: m/44'/60'/0'/0/0/44'/60'/0'/0/1 -- 偏移路径在这里被捏合
//    建议：
//        在v6的repo中已有于此相关的报告等待处理中。在源码更新之前，若想达到通常期待的与v5相一致的结果，
//        可以使用下面的方式来衍生钱包，暂时避免使用derivePath()：
//            ethers.HDNodeWallet.fromPhrase(seedPhrase, '', path)
//        seedPhrase即为助记词, 就用mnemonic即可。
//
//    let hdNodeNew = hdNode.derivePath(i.toString());
//    let walletNew = new ethers.Wallet(hdNodeNew.privateKey);
//    console.log(`第${i+1}个钱包地址： ${walletNew.address}`)
//    wallets.push(walletNew);
let basePath = "m/44'/60'/0'/0"
let addresses = []
for (let i = 0; i < numWallet; i++) {
  let hdNodeNew = hdNode.derivePath(i.toString())
  let walletNew = new ethers.Wallet(hdNodeNew.privateKey)
  addresses.push(walletNew.address)
}
console.log(addresses)
const amounts = Array(20).fill(ethers.parseEther('0.0001'))
console.log(`发送数额：${amounts}`)

// 3. 创建provider和wallet，发送代币用
//准备 alchemy API 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md
const ALCHEMY_SEPOLIA_URL = `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_KEY}`
const provider = new ethers.JsonRpcProvider(ALCHEMY_SEPOLIA_URL)

// // 利用私钥和provider创建wallet对象
// // 如果这个钱包没goerli测试网ETH了
// // 请使用自己的小号钱包测试，钱包地址: 0x338f8891D6BdC58eEB4754352459cC461EfD2a5E ,请不要给此地址发送任何ETH
// // 注意不要把自己的私钥上传到github上
// // 利用私钥和provider创建wallet对象
const privateKey = `${process.env.WALLET_PRIVATE_KEY}`
const wallet = new ethers.Wallet(privateKey, provider)

// 4. 声明Airdrop合约
// Airdrop的ABI
const abiAirdrop = [
  'function multiTransferToken(address,address[],uint256[]) external',
  'function multiTransferETH(address[],uint256[]) public payable'
]

// Airdrop合约地址（Goerli测试网）
const addressAirdrop = `${process.env.GOERLI_CONTRACT_TEST2}`
// 声明Airdrop合约
const contractAirdrop = new ethers.Contract(addressAirdrop, abiAirdrop, wallet)

// 5. 声明WETH合约
// WETH的ABI
const abiWETH = [
  'function balanceOf(address) public view returns(uint)',
  'function transfer(address, uint) public returns (bool)',
  'function approve(address, uint256) public returns (bool)'
]
// WETH合约地址（Goerli测试网）
// const addressWETH = `${process.env.GOERLI_CONTRACT_TEST1}` // WETH Contract
const addressWETH = `${process.env.CONTRACT_TEST_ADDRESS_WETH}` // WETH Contract
// 声明WETH合约
const contractWETH = new ethers.Contract(addressWETH, abiWETH, wallet)

const main = async () => {
  // 6. 读取一个地址的ETH和WETH余额
  console.log('\n3. 读取一个地址的ETH和WETH余额')
  //读取WETH余额
  console.log(addresses[10])
  const balanceWETH = await contractWETH.balanceOf(addresses[10])
  console.log(`WETH持仓: ${ethers.formatEther(balanceWETH)}\n`)
  //读取ETH余额
  const balanceETH = await provider.getBalance(addresses[10])
  console.log(balanceETH)
  // console.log(`ETH持仓: ${ethers.formatEther(balanceETH)}\n`)

  const myETH = await provider.getBalance(wallet)
  const myToken = await contractWETH.balanceOf(wallet.getAddress())

  // 如果钱包ETH足够和WETH足够
  if (
    ethers.formatEther(myETH) > 0.002 &&
    ethers.formatEther(myToken) >= 0.002
  ) {
    // 7. 调用multiTransferETH()函数，给每个钱包转 0.0001 ETH
    console.log('\n4. 调用multiTransferETH()函数，给每个钱包转 0.0001 ETH')
    // 发起交易
    const tx = await contractAirdrop.multiTransferETH(addresses, amounts, {
      value: ethers.parseEther('0.002')
    })
    // 等待交易上链
    await tx.wait()
    // console.log(`交易详情：`)
    // console.log(tx)
    const balanceETH2 = await provider.getBalance(addresses[10])
    console.log(`发送后该钱包ETH持仓: ${ethers.formatEther(balanceETH2)}\n`)

    // 8. 调用multiTransferToken()函数，给每个钱包转 0.0001 WETH
    console.log('\n5. 调用multiTransferToken()函数，给每个钱包转 0.0001 WETH')
    // 先approve WETH给Airdrop合约
    const txApprove = await contractWETH.approve(
      addressAirdrop,
      ethers.parseEther('1')
    )
    await txApprove.wait()
    // 发起交易
    const tx2 = await contractAirdrop.multiTransferToken(
      addressWETH,
      addresses,
      amounts
    )
    // 等待交易上链
    await tx2.wait()
    // console.log(`交易详情：`)
    // console.log(tx2)
    // 读取WETH余额
    const balanceWETH2 = await contractWETH.balanceOf(addresses[10])
    console.log(`发送后该钱包WETH持仓: ${ethers.formatEther(balanceWETH2)}\n`)
  } else {
    // 如果ETH和WETH不足
    console.log('ETH不足，请使用自己的小号钱包测试，并兑换一些WETH')
    console.log('1. chainlink水龙头: https://faucets.chain.link/goerli')
    console.log('2. paradigm水龙头: https://faucet.paradigm.xyz/')
  }
}

main()
