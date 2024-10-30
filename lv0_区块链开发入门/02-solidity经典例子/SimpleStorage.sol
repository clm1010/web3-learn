// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title SimpleStorage 读取和写入状态变量
 */
contract SimpleStorage {
    // 写入或更新状态变量，你需要发送交易
    uint256 public num;

    /// @dev 写入状态变量
    function set(uint256 _num) public {
        num = _num;
    }

    /// @dev 读取状态变量
    function get() public view returns (uint256) {
        return num;
    }
}
