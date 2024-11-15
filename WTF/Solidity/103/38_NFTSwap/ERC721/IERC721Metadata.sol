// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
* @dev IERC721Metadata是ERC721的拓展接口
*/
interface IERC721Metadata {
    /**
    * @dev 返回代币名称
    */
    function name() external view returns (string memory);
    /**
    * @dev 返回代币代号
    */
    function symbol() external view returns (string memory);
    /**
    * @dev 通过 tokenId 查询 metadata 的链接url，ERC721特有的函数
    */
    function tokenURI(uint256 tokenId) external view returns (string memory);
}