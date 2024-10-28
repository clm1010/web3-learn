// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
* @title constructors 构造函数是在创建合约时执行的可选函数
* 以下是如何向构造函数传递参数的示例
*/

// 基础合约 X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// 基础合约 Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 初始化父合约带参数的方式有2种

// 在继承列表中传递参数
contract B is X("Input to X"), Y("Input to Y") {}

contract C is X, Y {
    // 在构造函数中传递参数，类似于函数修饰符
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// 父构造函数始终按照继承顺序调用，而不管子合约的构造函数中列出的父合约的顺序如何。

// 构造函数调用的顺序：
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

// 构造函数调用的顺序：
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}