// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/**
 * @title HelloWorld
 */
contract HelloWorld {
    string public greet = "Hello World!";

    string storeMsg;

    function set(string memory message) public {
        storeMsg = message;
    }

    function get() public view returns (string memory) {
        return storeMsg;
    }
}
