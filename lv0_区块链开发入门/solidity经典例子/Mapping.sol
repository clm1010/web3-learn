// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Mapping (映射)
 */
contract Mapping {
    // keyType 可以是任何内置值类型、字节、字符串或任何合约
    // valueType 可以是任何类型，包括另一个Mapping(映射)或Array(数组)
    // Mapping (映射)不可迭代

    // 从地址映射到 uint
    mapping(address => uint256) public myMap;

    function get(address _addr) public view returns (uint256) {
        // mapping总是返回一个值
        // 如果该值从未设置，它将返回默认值
        return myMap[_addr];
    }

    function set(address _addr, uint256 _i) public {
        // 更新此地址的值
        myMap[_addr] = _i;
    }
}

/**
 * @title Mapping (嵌套映射)
 */
contract NestedMapping {
    // 嵌套映射（从地址映射到另一个映射）
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint256 _i) public view returns (bool) {
        // 可以从嵌套映射中获取值
        // 即使没有初始化
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint256 _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint256 _i) public {
        delete nested[_addr1][_i];
    }
}
