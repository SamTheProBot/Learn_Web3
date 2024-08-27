// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library ShaadiReturns {
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface dalaaliRate = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = dalaaliRate.latestRoundData();
        return uint256(answer * 1e10);
    }

    function partyFincialCondition() internal view returns (uint256) {
        AggregatorV3Interface dalaaliRate = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return dalaaliRate.version();
    }

    function getConversionRate(
        uint256 ethAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
}
