// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title Gas
 */
contract Gas {
    uint256 public i = 0;

    // 用完你发送的所有 Gas 会导致你的交易失败
    // 状态改变被撤消
    // 消耗的 Gas 不会退还
    function forever() public {
        // 这里我们运行一个循环，直到所有的 gas 都用完并且交易失败
        while (true) {
            i += 1;
        }
    }
}
