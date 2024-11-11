// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

// 第10讲合约继承中的Yeye合约
contract Yeye {
    event Log(string msg);

    // 定义3个function: hip(), pop(), yeye()，Log值为Yeye。
    function hip() public virtual{
        emit Log("Yeye hip");
    }

    function pop() public virtual{
        emit Log("Yeye pop");
    }

    function yeye() public virtual{
        emit Log("Yeye");
    }
}