// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

/**
 * @title 控制流
 */
contract InsertionSort {
    // if else
    function ifElseTest(uint256 _number) public pure returns (bool) {
        if (_number == 0) {
            return true;
        } else {
            return false;
        }
    }

    // for 循环
    function forLoopTest() public pure returns (uint256) {
        uint sum = 0;
        for (uint i = 0; i < 10; i++) {
            sum += i;
        }
        return sum;
    }

    // while
    function whileTest() public pure returns (uint256) {
        uint sum = 0;
        uint i = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        return sum;
    }

    // do-while
    function doWhileTest() public pure returns (uint256) {
        uint sum = 0;
        uint i = 0;
        do {
            sum += i;
            i++;
        } while (i < 10);
        return sum;
    }

    // 三元运算符 ternary/conditional operator
    function ternaryTest(uint256 x, uint256 y) public pure returns (uint256) {
        // return the max of x and y
        return x >= y ? x : y;
    }

    // 插入排序 错误版
    function insertionSortWrong(uint[] memory a) public pure returns (uint[] memory) {
        for (uint i = 1; i < a.length; i++) {
            uint temp = a[i];
            uint j = i - 1;
            while ((j >= 0) && (temp < a[j])) {
                a[j + 1] = a[j];
                j--;
            }
            a[j + 1] = temp;
        }
        return a;
    }

    // Solidity中最常用的变量类型是uint，也就是正整数，取到负值的话，会报underflow错误。而在插入算法中，变量j有可能会取到-1，引起报错。
    // 这里，我们需要把j加1，让它无法取到负值。正确代码：
    // 插入排序 正确版
    function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
        // note that uint can not take negative value
        for (uint i = 1; i < a.length; i++) {
            uint temp = a[i];
            uint j = i;
            while ((j >= 1) && (temp < a[j-1])) {
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return a;
    }
}
