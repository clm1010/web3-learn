// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Variables 变量 （Solidity 中有 3 种类型的变量、local（局部）、state（状态）、global（全局））
 */
contract Variables {
    // 状态变量存储在区块链上
    string public text = "Hello";
    uint256 public num = 123;

    function doSomething() public {
        // local（局部）
        // 在函数内部声明
        // 未存储在区块链上
        // 局部变量不会保存到区块链
        uint256 i = 456;

        // global（全局)
        // 提供有关区块链的信息
        // 以下是一些全局变量
        uint256 timestamp = block.timestamp; // 当前区块时间戳
        address sender = msg.sender; // 调用者地址
    }
}
