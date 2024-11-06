// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * @title Events 事件
 */
contract Events {
    // Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：
    // 响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
    // 经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

    // 定义_balances映射变量，记录每个地址的持币数量
    mapping(address => uint256) public _balances;

    // 定义Transfer event，记录transfer交易的转账地址，接收地址和转账数量
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 定义_transfer函数，执行转账逻辑
    function _transfer(address from, address to, uint256 amount) external {
        _balances[from] = 10000000; // 给转账地址一些初始代币
        _balances[from] -=  amount; // from地址减去转账数量
        _balances[to] += amount; // to地址加上转账数量
        // 释放事件
        emit Transfer(from, to, amount);
    }
}