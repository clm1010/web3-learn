// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Immutable
 */
contract Immutable {
    // immutable 变量类似于常量,初始化之后不能修改
    // immutable 在声明的时候可以初始化
    // immutable 变量的值可以在构造函数中初始化
    // immutable 不能初始化两次
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    // 在构造函数中初始化
    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
