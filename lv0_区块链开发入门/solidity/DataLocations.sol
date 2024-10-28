// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title DataLocations 数据位置 - 存储、内存和调用数据
 * 变量被声明为 storage、memory 或 calldata，以明确指定数据的位置
 */
contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;

    struct MyStruct {
        uint256 foo;
    }

    mapping(uint256 => MyStruct) myStructs;

    function f() public {
        // 使用状态变量调用 _f
        _f(arr, map, myStructs[1]);
        // 从映射中获取结构体
        MyStruct storage myStruct = myStructs[1];
        // 在内存中创建一个结构体
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // 使用存储变量做一些事情
    }

    // 可以返回内存变量
    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // 使用内存阵列做一些事情
    }

    function h(uint256[] calldata _arr) external {
        // 对 calldata 数组进行一些操作
    }
}
