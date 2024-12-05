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

## 部署 Rcc token

```shell
npx hardhat ignition deploy ./ignition/modules/Rcc.js
```

部署之后在 terminal 拿到合约地址,比如: `0x264e0349deEeb6e8000D40213Daf18f8b3dF02c3`

## 部署完 Rcc Token,拿以上地址作为 RCCStake 合约的初始化参数,在 RCCStake 中设置

```shell
const RccToken = "0x264e0349deEeb6e8000D40213Daf18f8b3dF02c3";
```

## 将 stake 合约部署到 sepolia 上

```shell
npx hardhat run scripts/RCCStake.js --network sepolia
```
