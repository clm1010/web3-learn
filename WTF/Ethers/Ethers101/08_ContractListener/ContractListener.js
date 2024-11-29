import 'dotenv/config'
// 监听合约方法：
// 1. 持续监听
// contractUSDT.on("事件名", Listener)
// 2. 只监听一次
// contractUSDT.once("事件名", Listener)

import { ethers } from 'ethers'

// 准备 alchemy API
// 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md
const ALCHEMY_MAINNET_URL = `https://eth-mainnet.g.alchemy.com/v2/${process.env.ALCHEMY_KEY}`

// 连接主网 provider
const provider = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL)

// USDT的合约地址
const contractAddress = `${process.env.CONTRACT_TEST_ADDRESS_USDT}`
// 构建USDT的Transfer的ABI
const abi = [
  'event Transfer(address indexed from, address indexed to, uint value)'
]
// 生成USDT合约对象
const contractUSDT = new ethers.Contract(contractAddress, abi, provider)

const main = async () => {
  // 监听USDT合约的Transfer事件

  try {
    // 只监听一次
    console.log('\n1. 利用contract.once()，监听一次Transfer事件')
    contractUSDT.once('Transfer', (from, to, value) => {
      // 打印结果
      console.log(
        `ONCE: ${from} -> ${to} ${ethers.formatUnits(
          ethers.getBigInt(value),
          6
        )}`
      )
    })

    // 持续监听USDT合约
    console.log('\n2. 利用contract.on()，持续监听Transfer事件')
    contractUSDT.on('Transfer', (from, to, value, event) => {
      console.log(
        // 打印结果
        `${from} -> ${to} ${ethers.formatUnits(ethers.getBigInt(value), 6)}`,
        event,
        new Date().toLocaleString()
      )
    })
  } catch (e) {
    console.log(e)
  }
}
main()
