/* Write a Solidity smart contract called SimpleStorage that allows users to store and retrieve a number. The contract should:

Have a private variable to store a number.
Provide a function called storeNumber(uint256 _number) that allows users to store a new number.
Provide a function called retrieveNumber() that returns the stored number.
Deploy this contract on a testnet (like Sepolia or Goerli) and test storing and retrieving numbers.
Let me know if you need hints or guidance! 🚀 */

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    uint256 private favoriteNumber;

    function storeNumber(uint256 _number) public {
        favoriteNumber = _number;
    }    

    function retrieveNumber() public view returns (uint256) {
        return favoriteNumber;
    }
}