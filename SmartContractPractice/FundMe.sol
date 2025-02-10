//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
//works on RemixIde
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {


    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable  {
        require (getConversionRate(msg.value) > minimumUsd , "didnt send enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public {}

    function getPrice() public view returns (uint256) {
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //abi
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();

        return uint256(price * 1e10);
    } 

    function getConversionRate(uint256 _ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * _ethAmount) / 1e10;
        return ethAmountInUsd;

    }


    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

    }

}