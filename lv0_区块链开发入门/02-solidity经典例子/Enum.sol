// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Enum 枚举类
 * Solidity支持枚举，它们对模型选择和状态跟踪很有用
 */
contract Enum {
    // 枚举可以在合约之外声明
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // 默认值是类型定义中列出的第一个元素，在本例中为“Pending”
    Status public status;

    // Returns uint // 返回 uint
    // Pending - 0 // 待处理
    // Shipped - 1 // 已发送
    // Accepted - 2 // 已接受
    // Rejected - 3 // 已拒绝
    // Canceled - 4 // 已取消

    function get() public view returns (Status) {
        return status;
    }

    // 通过将 uint 传递到输入来更新状态
    function set(Status _status) public {
        status = _status;
    }

    // 删除将枚举重置为其第一个值 0
    function reset() public {
        delete status;
    }
}
