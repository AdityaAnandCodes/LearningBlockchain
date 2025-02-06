/* Write a Solidity smart contract called SimpleWallet that allows users to deposit, withdraw, and check their balance. The contract should:

Allow users to deposit ETH into the contract.
Allow users to withdraw ETH they have deposited.
Provide a function to check their balance.
Ensure that users can only withdraw their own deposited ETH.
Deploy and test it on a testnet (like Sepolia or Goerli).
Let me know if you need hints! 🚀 */

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleWallet {
    mapping (address => uint256) private balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require (balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}