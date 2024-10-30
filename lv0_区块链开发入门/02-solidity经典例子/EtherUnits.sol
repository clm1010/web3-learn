// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title EtherUnits
 */
contract EtherUnits {
    // 交易用以太币支付
    // 类似于 1 美元等于 100 美分，1 以太等于 10(18) wei

    uint256 public oneWei = 1 wei; // 1
    // 1 wei 等于 1
    bool public isOneWei = (oneWei == 1);

    uint256 public oneGwei = 1 gwei; // 1000000000
    // 1 gwei 等于 10^9 gwei
    bool public isOneGwei = (oneGwei == 1e9); // 1*10^9

    uint256 public oneEther = 1 ether; // 1000000000000000000
    // 1 ether(以太) 等于 10^18 wei 
    bool public isOneEther = (oneEther == 1e18); // 1*10^18
}
