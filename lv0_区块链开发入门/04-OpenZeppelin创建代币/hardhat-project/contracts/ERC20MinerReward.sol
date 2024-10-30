// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

// 允许合约找到我们将在自己的合约中使用的 ERC20 合约定义
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title OpenZeppelin创建代币 ERC20
 */
contract ERC20MinerReward is ERC20 {
    // LogNewAlert事件, 合约中发出或调用它
    event LogNewAlert(string description, address indexed _from, uint256 _n);

    // 构造函数使用符号 MRW 定义⼀个名为 MinerReward的新 ERC20 代币
    constructor() ERC20("MinerReward", "MRW") {}

    // 当前区块的矿工 block.coinbase 会因挖掘该区块获得 20 个 MRW 代币，并且系统会发出⼀个事件
    function _reward() public {
        _mint(block.coinbase, 20);
        emit LogNewAlert("_rewarded", block.coinbase, block.number);
    }
}
