// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

contract SimpleStorage {
    uint256 public YourFavNumber = 0;

    function setYourFavNumber(uint256 _YourFavNumber) public {
        YourFavNumber = _YourFavNumber;
    }

    function isYourNumberLuckey() public view returns (bool) {
        if (YourFavNumber % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }
}
