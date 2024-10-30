// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
* @title Account 
*/
contract Account {
    uint256 public balance;
    uint256 public constant MAX_UINT = 2 ** 256 - 1;

    function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;

        // 如果balance（余额 ） + _amount >= balance（余额 ），则balance（余额 ） + _amount 不会溢出
        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;

        // balance（余额 ）- 如果balance（余额 ） >= _amount，_amount 不会溢出
        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }
}