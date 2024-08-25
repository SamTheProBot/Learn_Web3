// address 0x694AA1769357215DE4FAC081bf1f309aDC325306
// 275222000000
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "./daala.sol";

contract FundMe {
    using ShaadiReturns for uint256; 
    uint256 public minimumDaahejAmount = 50 * 1e18;
    address public Dulha;

    constructor(){
        Dulha = msg.sender;
    }

    address[] public GiftDoners;
    mapping(address => uint256) public DaahejAmount;

    function Daahej() public payable {
        require(msg.value.getConversionRate() >= minimumDaahejAmount, "bitiya ke saadi mai paisa nahi mikala");
        GiftDoners.push(msg.sender);
        DaahejAmount[msg.sender] += msg.value;
    }

    function OrderFortuner() public {
        for (uint128 i = 0; i < GiftDoners.length; i++) {
            address risteDaarKaNaam = GiftDoners[i];
            DaahejAmount[risteDaarKaNaam] = 0;
        }
        GiftDoners = new address[](0);

        payable (msg.sender).transfer(address(this).balance);
    }

    modifier onlyDulahPariwar{
        require(msg.sender == Dulha, "aabe saale tu dulha nahi hai, baag yaha se");
        _;
    }

}