// 部署 MyToken 合约（
async function main() {
  try {
    console.log('部署 LM Token (ERC20Mock ERC20)...')
    const ERC20Mock = await ethers.getContractFactory('ERC20Mock')
    const lmToken = await ERC20Mock.deploy(
      'LM Token',
      'LMT',
      18,
      ethers.parseEther('1000000')
    )
    await lmToken.waitForDeployment()
    console.log(`ERC20Mock LM Token 部署地址在: ${lmToken.target}`)
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
