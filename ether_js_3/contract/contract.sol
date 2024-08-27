// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract Token {
    uint256 youFavNumber = 0;
    string youFavSentence = "Like i Know :{";

    function setYourFavNumber(uint256 _newNumber) public {
        youFavNumber = _newNumber;
    }

    function getYourFavNumber() public view returns (uint256) {
        return youFavNumber;
    }

    function getYourFavSentence() public view returns (string memory) {
        return youFavSentence;
    }

    function setYourFavSentence(string memory _newSentence) public {
        youFavSentence = _newSentence;
    }
}
