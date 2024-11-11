// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

/**
 * @title 值类型(Value Type)
 */
contract ValueTypes {
    // 布尔值
    bool public _bool = true;

    // 布尔运算
    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不相等

    // 整型
    int256 public _int = -1; // 整数，包括负数
    uint256 public _uint = 1; // 正整数
    uint256 public _number = 20220330; // 256位正整数

    // 整数运算
    uint256 public _number1 = _number + 1; // + ， - ，* ， /
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小

    // 地址类型
    address public _address = 0x88219c099C5391B237291F37f733B843A3e23117; // 普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address

    // 固定长度的字节数组
    bytes32 public _byte32 = "MinSolidity"; // MiniSolidity 变量以字节的方式存储进变量 _byte32，16进制 0x4d696e536f6c6964697479000000000000000000000000000000000000000000
    bytes1 public _byte = _byte32[0]; // _byte 变量的值为 _byte32 的第一个字节，0x4d

    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet {
        Buy,
        Hold,
        Sell
    }
    // 创建enum变量 action
    // ActionSet action = ActionSet.Buy; // action 被赋予了 ActionSet的第一元素
    ActionSet action = ActionSet.Sell; // 这里赋予第三个元素，所以转成uint数值就是2（从0开始)

    // enum可以和uint显式的转换
    function enumToUint() external view returns (uint256) {
        return uint256(action); // 显式转换，把enum转换成了uint
    }
}
