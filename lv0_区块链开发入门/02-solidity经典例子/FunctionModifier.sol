// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title FunctionModifier
 * 修饰符是可以在函数调用之前和/或之后运行的代码
 *
 * 修饰符可用于：
 *  Restrict access 限制访问
 *  Validate inputs 验证输入
 *  Guard against reentrancy hack 防范重入攻击
 */
contract FunctionModifier {
    // 我们将使用这些变量来演示如何使用修饰符
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        // 将交易发送者设置为合约的所有者
        owner = msg.sender;
    }

    // modifier 修饰符，用于检查调用者是否是合约的所有者
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // 下划线是仅在函数修饰符内使用的特殊字符，它告诉 Solidity 执行其余代码
        _;
    }

    // modifier 修饰符可以接受输入。此modifier修饰符检查传入的地址不是无效地址
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    // 修饰符可以在函数之前和/或之后调用
    // 此修饰符可防止函数在执行过程中被调用
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}
