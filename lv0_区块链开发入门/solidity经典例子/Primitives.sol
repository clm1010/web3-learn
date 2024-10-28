// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Primitives 原始数据类型
 */
contract Primitives {
    bool public boo = true;

    /* 
        uint 代表无符号整数，即非负整数 有不同大小可供选择
        uint8   ranges from 0 to 2 ** 8 - 1
        uint16  ranges from 0 to 2 ** 16 - 1
        ...
        uint256 ranges from 0 to 2 ** 256 - 1
    */
    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123; // uint 是 uint256 的别名

    /*
    int类型允许使用负数.
    像uint一样，从int8到int256也有不同的范围
    
    int256 ranges from -2 ** 255 to 2 ** 255 - 1
    int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123; // int 与 int256 相同

    // 整数的最小值和最大值
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    /*
        在Solidity中，数据类型byte表示一个字节序列。
        Solidity提供了两种类型的字节类型：
        - fixed-sized 固定大小的字节数组
        - dynamically-sized 动态大小的字节数组。
        Solidity中的术语bytes表示一个动态的字节数组。
        它是byte[]的简写。
    */
    bytes1 a = 0xb5; // [10110101]
    bytes1 b = 0x56; // [01010110]

    // 默认值
    // 未赋值的变量有默认值
    bool public defaultBoo; // false
    uint256 public defaultUint; // 0
    int256 public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}
