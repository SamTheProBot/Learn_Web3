// address 0x694AA1769357215DE4FAC081bf1f309aDC325306
// 275222000000
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;
import "./daala.sol";

error notDulha();

contract FundMe {
    using ShaadiReturns for uint256;
    uint256 public constant MIN_DAAHEJ = 50 * 1e18;
    address public immutable Dulha;

    constructor() {
        Dulha = msg.sender;
    }

    address[] public GiftDoners;
    mapping(address => uint256) public DaahejAmount;

    function Daahej() public payable {
        if (msg.value.getConversionRate() >= MIN_DAAHEJ) revert notDulha();
        GiftDoners.push(msg.sender);
        DaahejAmount[msg.sender] += msg.value;
    }

    function OrderFortuner() public onlyDulahPariwar {
        for (uint128 i = 0; i < GiftDoners.length; i++) {
            address risteDaarKaNaam = GiftDoners[i];
            DaahejAmount[risteDaarKaNaam] = 0;
        }
        GiftDoners = new address[](0);

        payable(msg.sender).transfer(address(this).balance);
    }

    modifier onlyDulahPariwar() {
        // if (msg.sender != Dulha) revert notDulha();
        require(msg.sender == Dulha, notDulha());
        _;
    }

    receive() external payable {
        Daahej();
    }

    fallback() external payable {
        Daahej();
    }
}
