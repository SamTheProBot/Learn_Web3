// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract SimpleStorage {
    struct player {
        string name;
        uint32 age;
        bool isEligible;
    }

    int256 YourFavNumber = 0;

    player[] public AllPlarticipent;

    mapping(string => uint32) public cheakAge;

    function SetYouFavNumber(int256 _YouFavNumber) public virtual {
        YourFavNumber = _YouFavNumber;
    }

    function GetYouFavNumber() public view returns (int256) {
        return YourFavNumber;
    }

    function addAthelete(
        string memory _name,
        uint32 _age,
        bool _isEligible
    ) public {
        AllPlarticipent.push(
            player({name: _name, age: _age, isEligible: _isEligible})
        );
        cheakAge[_name] = _age;
    }
}
