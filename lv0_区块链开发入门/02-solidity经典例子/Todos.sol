// SPDX-License-Identifier: MIT

/**
 * @title Todos 原始数据类型
 * 您可以通过创建结构来定义自己的类型
 * 它们对于将相关数据分组很有用
 * 结构可以在合约之外声明，并导入到另一个合约中
 */
pragma solidity ^0.8.24;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // Todo 结构数组
    Todo[] public todos;

    function create(string calldata _text) public {
        // 初始化结构的 3 种方法
        // 像函数一样调用它
        todos.push(Todo(_text, false));

        // 键值映射
        todos.push(Todo({text: _text, completed: false}));

        // 初始化一个空结构然后更新它
        Todo memory todo;
        todo.text = _text;
        // todo.completed 初始化为 false

        todos.push(todo);
    }

    // Solidity 自动为 'todos' 创建了一个 getter，因此实际上不需要此功能。
    function get(uint256 _index)
        public
        view
        returns (string memory text, bool completed)
    {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // 更新 text
    function updateText(uint256 _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // 更新 completed
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
