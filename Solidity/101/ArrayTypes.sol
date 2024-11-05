// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * @title 引用类型 array，struct
 */
contract ArrayTypes {
    // 固定长度 Array
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;

    // 可变长度 Array
    uint[] array4;
    bytes[] array5;
    address[] array6;
    bytes array7;

    // 初始化可变长度 Array
    uint[] array8 = new uint[](5);
    bytes array9 = new bytes(9);

    // 给可变长度数组赋值
    function initArray() external pure returns (uint[] memory) {
        uint[] memory x = new uint[](3);
        x[0] = 1;
        x[1] = 3;
        x[2] = 4;
        return (x);
    }

    // push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
    function arrayPush() public returns (uint[] memory) {
        uint[2] memory a = [uint(1), 2];
        array4 = a;
        array4.push(3);
        return array4;
    }

    // length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
    function arrayLength() public view returns(uint)  {
       return  array4.length;
    }

    // pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。
    function popArray() public returns (uint[] memory) {
        array4.pop();
        return  array4;
    }
}
