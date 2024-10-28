// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Counter 增加和减少此合约中的计数存储
 */
contract Counter {
    uint256 public count;

    // 获取计数的函数
    function get() public view returns (uint256) {
        return count;
    }

    // 函数计数加1
    function inc() public {
        count += 1;
    }

    // 函数计数減1
    function dec() public {
        count -= 1;
    }
}
