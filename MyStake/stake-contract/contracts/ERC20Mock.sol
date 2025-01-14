// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Mock is ERC20 {
    uint8 private _decimals; //代币精度

    // constructor(
    //     string memory name_,
    //     string memory symbol_,
    //     uint8 decimals_,
    //     uint256 totalSupply_
    // ) ERC20(name_, symbol_) {
    //     _decimals = decimals_;
    //     // 初始供应量可以在这里定义，或者留空以便之后通过 mint 函数铸造
    //     // 将初始供应量铸造到部署者地址
    //     _mint(msg.sender, totalSupply_);
    // }

    // 合约的构造函数
    // 两个参数 name 和 symbol，分别代表代币的名称和符号
    // 初始供应量可以在这里定义，或者留空以便之后通过 mint 函数铸造
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals_,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _decimals = decimals_;
        // _mint：这是 ERC20 合约中的内部函数，用于铸造新的代币

        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }
}
