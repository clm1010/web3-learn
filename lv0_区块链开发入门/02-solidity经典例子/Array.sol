// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Array (数组)
 */

contract Array {
    // 初始化数组的几种方法
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];

    // 固定大小数组，所有元素初始化为 0
    uint256[10] public myFixedSizeArr;

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }

    // Solidity 可以返回整个数组
    // 但是对于长度可以无限增长的数组，应该避免使用该函数
    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    function push(uint256 i) public {
        // 追加到数组
        // 这将使数组长度增加1
        arr.push(i);
    }

    function pop() public {
        // 从数组中删除最后一个元素
        // 这将使数组长度减少 1
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        // 删除不会改变数组长度
        // 它将索引处的值重置为其默认值，在本例中为 0
        delete arr[index];
    }

    function examples() external {
        // 在内存中创建数组，只能创建固定大小
        uint256[] memory a = new uint256[](5);
    }
}
