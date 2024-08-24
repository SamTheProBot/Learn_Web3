// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "./simplStorage.sol"; 

contract ExtraInfo is SimpleStorage {
  function SetYouFavNumber(int256 _YouFavNumber) public override {
    YourFavNumber  = _YouFavNumber + 5;
  }
}
