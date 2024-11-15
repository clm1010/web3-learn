// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
* @title 安全的数学
*/
contract SafeMath {
    // x = 0 时，在去减 就会溢出了，会 revert 报错
    function testUnderflow() public pure returns (uint) {
        uint x = 0;
        x--;
        return x;
    }

    // 加上 unchecked 不检验，不会报错并得到 uint256 最大值
    // uint256: 115792089237316195423570985008687907853269984665640564039457584007913129639935
    function testUncheckedUnderflow() public pure returns (uint) {
        uint x = 0;
        unchecked { x--; }
        return x;
    }
}