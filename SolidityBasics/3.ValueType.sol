// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

/**
* @title 类型和值
*/
contract ValueTypes {
    bool public b = true;
    // uint 无符号 正整数
    uint public u = 123; // uint =  uint256  0 to 2**256 - 1
                         //         uint8    0 to 2**8 - 1
                         //         uint16   0 to 2**16 - 1
    // int 有符号 整数 默认256位 可以代表负数
    int public i = -123; // int = int256   -2**255 to 2**255 - 1
                         //       int128   -2**127 to 2**127 - 1
    // type().min; 最小值
    int public minInt = type(int).min; //  -57896044618658097711785492504343953926634992332820282019728792003956564819968

    // type().max; 最大值
    int public maxInt = type(int).max; // 57896044618658097711785492504343953926634992332820282019728792003956564819967

    // 地址 address
    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    bytes32 public b32 = 0x4d696e536f6c6964697479000000000000000000000000000000000000000000;
}