// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

/**
 * @title 变量数据存储和作用域storage/memory/calldata
 * Solidity数据存储位置有三类：storage、memory、calldata
 * storage类型的数据存在链上，类似计算机的硬盘，消耗gas多
 * memory和calldata类型的临时存在内存里，消耗gas少
 */
contract DataStorage {
    uint[] x = [1, 2, 3];

    //声明一个storage的变量 xStorage，指向x，修改Storage也会影响x
    function fStorage() public {
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }

    function fMemory() public view {
        //声明一个Memory的变量xMemory，复制x，修改xMemory不会影响x
        uint[] memory xMemory = x;
        xMemory[0] = 100;
    }

    function fCalldata(uint[] calldata _x) public pure returns (uint[] calldata) {
        // 参数为calldata数组，不能被修改
        // _x[0] = 0; //这样修改会报错
        return (_x);
    }
}
