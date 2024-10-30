// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title for 和 while 循环
 */
contract Loop {
    function loop() public {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                // continue 跳到下一次迭代
                continue;
            }
            if (i == 5) {
                // break 退出循环
                break;
            }
        }

        uint256 j;
        while (j < 10) {
            j++;
        }
    }
}
