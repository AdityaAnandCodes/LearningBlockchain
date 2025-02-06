/* Write a Solidity smart contract called "TokenAirdrop" that distributes ERC20 tokens to eligible users. The contract should:

Allow the owner (deployer) to add addresses eligible for the airdrop.
Allow eligible users to claim their tokens only once.
Ensure that each user receives a fixed amount of tokens when claiming.
Prevent users who have already claimed from claiming again.
Allow the owner to withdraw any unclaimed tokens after the airdrop ends.
🚀 Bonus Challenge (Optional):

Implement a time limit for claiming tokens.
After the time limit expires, prevent further claims.
Try implementing this, and let me know if you need hints! 😃 */ 

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AirDrop {
    address public owner;  
    mapping (address => bool) public isEligible;
    mapping (address => bool) public hasClaimed;
    uint256 public maxClaim = 1000;


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require (msg.sender == owner ,  "Only owner can call this function");
        _;
    }

    function AddEligible(address _address) public onlyOwner {
        require (!isEligible[_address], "Address is already eligible");
        isEligible[_address] = true;
    }

    function claimTokens(IERC20 _token, uint256 _amount) public {
        require (isEligible[msg.sender], "Address is not eligible");
        require (!hasClaimed[msg.sender], "Address has already claimed tokens");
        require (_amount <= maxClaim, "Amount exceeds maximum claim");

        hasClaimed[msg.sender] = true;
        _token.transfer(msg.sender, _amount);
    }

    function withdrawUnclaimed(IERC20 _token, uint256 _amount) public onlyOwner {
        require (_token.balanceOf(address(this)) >= _amount, "Insufficient balance");
        _token.transfer(owner, _amount);
    }
}