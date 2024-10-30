// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Constants 常量
 */
contract Constants {
    // 常量是不可修改的变量
    // 它们的值是硬编码的，使用常量可以节省gas成本
    // 常量变量名大写
    address public constant MY_ADDRESS =
        0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;

    uint256 public constant MY_UINT = 123;
}
