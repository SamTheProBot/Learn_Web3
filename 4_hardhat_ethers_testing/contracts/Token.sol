// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "hardhat/console.sol";

contract Token {
    uint256 public unlockTime;
    address payable public owner;

    event Withdraw(uint256 amount, uint256 when);

    constructor(uint256 _unlocktime) payable {
        require(block.timestamp < _unlocktime, "time should be in future");
        unlockTime = _unlocktime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        require(block.timestamp >= unlockTime, "can't access your assets now");
        require(msg.sender == owner);

        emit Withdraw(address(this).balance, block.timestamp);
        owner.transfer(address(this).balance);
    }
}
