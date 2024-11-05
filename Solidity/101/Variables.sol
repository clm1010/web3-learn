// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

/**
 * @title 变量的作用域
 * 状态变量（state variable）
 * 局部变量（local variable）
 * 全局变量（global variable）
 */
contract Variables {
    // 状态变量
    // 状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明：
    uint public x = 1;
    uint public y;
    string public z;

    function foo() external {
        // 可以在函数里更改状态变量的值
        x = 5;
        y = 2;
        z = "0xAA";
    }

    // 局部变量
    // 局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明：
    function bar() external pure returns (uint) {
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return (zz);
    }

    // 全局变量
    // 全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用：
    function global() external view returns(address, uint, bytes memory) {
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return (sender, blockNum, data);
    }

    // 全局变量-以太单位与时间单位
    // Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。
    function weiUnit() external pure returns(uint) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUnit() external pure returns(uint) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUnit() external pure returns(uint) {
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

    // 时间单位
    // 可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。
    // 这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。
    // 因此，时间单位在Solidity中是一个重要的概念，有助于提高合约的可读性和可维护性。
    function secondsUnit() external pure returns(uint) {
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minutesUnit() external pure returns(uint) {
        assert(1 minutes == 60);
        assert(1 minutes == 60 seconds);
        return 1 minutes;
    }

    function hoursUnit() external pure returns(uint) {
        assert(1 hours == 3600);
        assert(1 hours == 60 minutes);
        return 1 hours;
    }

    function daysUnit() external pure returns(uint) {
        assert(1 days == 86400);
        assert(1 days == 24 hours);
        return 1 days;
    }

    function weeksUnit() external pure returns(uint) {
        assert(1 weeks == 604800);
        assert(1 weeks == 7 days);
        return 1 weeks;
    }
}
