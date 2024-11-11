// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

/**
 * @title 变量初始值
 */
contract InitialValue {
    // 值类型初始值
    bool public _bool; // false
    string public _string; // ""
    int256 public _int; // 0
    uint256 public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000
    bytes1 public _byte1; // 0x00
    enum ActionSet { Buy, Hold, Sell }
    ActionSet public _enum; // 第1个内容Buy的索引0

    function fi() internal{} // internal 空白函数
    function fe() external{} // external 空白函数
    
    
    // 引用类型初始值
    uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray; // `[]`

    mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping
    mapping(address => uint256) private _balances; // 默认值 0
    
    // 所有成员设为其默认值的结构体 0, 0
    struct Student {
        uint256 id;
        uint256 score;
    }
    Student public student;

    // delete操作符
    bool public _bool2 = true;
    function d() external {
        delete _bool2; // delete 会让_bool2变为默认值，false
    }

    // delete操作符
    string public _str = "true";
    function strD() external {
        delete _str; // delete 会让_str变为默认值，""
    }
}
