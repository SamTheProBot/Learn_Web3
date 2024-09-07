// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "hardhat/console.sol";
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 private constant MINIMUM_USD = 50 * 10 ** 18;
    address private immutable owner;
    address[] private funders;
    mapping(address => uint256) public addressToAmountFunded;
    AggregatorV3Interface priceFeed;

    constructor(address priceFeedAddress) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function EthValue() public payable returns (uint256) {
        return msg.value.getConversionRate(priceFeed);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(priceFeed) * 1e4 >= MINIMUM_USD,
            "insufficient funds"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        payable(msg.sender).transfer(address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "your not the owner sir");
        _;
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
