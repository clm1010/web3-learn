# stake-contract Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

## 安装依赖

```shell
npm install
```

## 编译

```shell
npx hardhat compile
```

## 测试部署、合约

```shell
npx hardhat test test/RCCStake.test.js
```

## 部署 RCC Token 和 RCCStake 到测试网 sepolia

```shell
npx hardhat run scripts/deploy.js  --network sepolia
```

## 部署成功后 执行 verify 验证 token 、合约或代理可升级合约

```shell
npx hardhat verify <Token 地址> <Token 参数: "RCC Token" "RCC" "18" "1000000000000000000000000"> --network sepolia
npx hardhat verify <合约地址或合约代理地址> --network sepolia
```

## 部署成功并验证成功后，执行 interact.js 初始化合约

```shell
npx hardhat run scripts/interact.js  --network sepolia
```
