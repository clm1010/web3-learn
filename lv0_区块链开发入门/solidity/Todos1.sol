// SPDX-License-Identifier: MIT

/**
 * @title Todos 声明并导入结构体
 *
 */
pragma solidity ^0.8.24;

// 导入StructDeclaration.sol文件
import "./StructDeclaration.sol";

contract Todos {
    // Todo 结构数组
    Todo[] public todos;
}