// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title Event
 * 事件允许记录到以太坊区块链。事件的一些用例是：
 * 监听事件并更新用户界面
 * 一种廉价的存储形式
 */
contract Event {
    // 事件声明 
    // 最多可以索引 3 个参数
    // 索引参数可帮助您通过索引参数筛选日志
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}