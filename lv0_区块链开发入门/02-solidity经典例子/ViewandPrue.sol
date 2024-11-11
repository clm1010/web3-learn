// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
* @title ViewAndPure
* Getter 函数可以声明为视图函数或纯函数
* View 函数声明不会改变任何状态
* Pure 函数声明不会更改或读取任何状态变量
*/
contract ViewAndPure {
    uint256 public x = 1;

    // Promise 声明不会改变任何状态
    function addToX(uint256 y) public view returns (uint256) {
        return x + y;
    }

    // 不会更改或读取任何状态变量
    function add(uint256 i, uint256 j) public pure returns (uint256) {
        return i + j;
    }
}