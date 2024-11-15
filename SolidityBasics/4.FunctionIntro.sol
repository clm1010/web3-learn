// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FunctionIntro {
    // external 表示外部函数，pure 不能读也不能写
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}