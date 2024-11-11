// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
* @title Error
* 错误将撤消交易期间对状态所做的所有更改
* 你可以通过调用 require、vert 或 assert 来抛出错误
*
* require 用于在执行之前验证输入和条件
* evert 与 require 类似，具体见下方代码
* assert 用于检查代码是否永远不应该为假。assert 失败可能意味着存在错误
*/
contract Error {
    function testRequire(uint256 _i) public pure {
        // Require 应该用来验证如下条件：
        // - 输入
        // - 执行前的条件
        // - 调用其他函数的返回值
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        // 当检查条件很复杂时，恢复很有用
        // 此代码的作用与上面的例子完全相同
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        // assert 仅应用于测试内部错误,以及检查不变量.

        // 这里我们assert num 始终等于 0 
        // 因为不可能更新 num 的值
        assert(num == 0);
    }

    // 自定义错误
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}
