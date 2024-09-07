// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// 0xF4C661F773FAfA9777D0e4e2CDAC84F55De00304

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

contract Lottery is VRFConsumerBaseV2Plus {
    enum LotteryState {
        OPEN,
        CALCULATING
    }

    uint16 private constant REQUESTCONFIRMATION = 1;
    uint32 private constant NUMWORDS = 1;
    uint256 private immutable i_entraceFee;
    address private immutable i_owner;
    address payable[] private s_players;
    uint256 private immutable i_subscriptionId;
    address private immutable i_vrfCoordinator =
        0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B;
    bytes32 private immutable i_gasLane =
        0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae;
    uint32 private immutable i_callbackGasLimit = 40000;

    address private s_recentWinner;
    LotteryState private s_lotteryState;

    event e_JoinLottery(address indexed player);
    event e_RequestLotteryWinner(uint256 indexed requestId);
    event e_WinnerPicked(address indexed recentWinner);

    constructor(
        uint256 entraceFee,
        uint256 subscriptionId
    ) VRFConsumerBaseV2Plus(i_vrfCoordinator) {
        i_owner = msg.sender;
        i_entraceFee = entraceFee;
        i_subscriptionId = subscriptionId;
        s_lotteryState = LotteryState.OPEN;
    }

    function JoinLottery() public payable {
        require(msg.value >= i_entraceFee, "this is not enough sweet heart!");
        require(s_lotteryState == LotteryState.OPEN, "lottery calculating");
        s_players.push(payable(msg.sender));
        emit e_JoinLottery(msg.sender);
    }

    function requestRandomNumber() external onlyOwner {
        s_lotteryState = LotteryState.CALCULATING;
        uint256 requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: i_gasLane,
                subId: i_subscriptionId,
                requestConfirmations: REQUESTCONFIRMATION,
                callbackGasLimit: i_callbackGasLimit,
                numWords: NUMWORDS,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );
        emit e_RequestLotteryWinner(requestId);
    }

    function fulfillRandomWords(
        uint256 /*requestId*/,
        uint256[] calldata randomWords
    ) internal override {
        uint256 winnerIndex = randomWords[0] % s_players.length;
        address payable recentWinner = s_players[winnerIndex];
        s_recentWinner = recentWinner;
        s_lotteryState = LotteryState.OPEN;
        s_players = new address payable[](0);
        (bool success, ) = recentWinner.call{value: address(this).balance}("");
        require(success, "not good, transfer failed");
        emit e_WinnerPicked(recentWinner);
    }

    function getRecentWinner() public view returns (address) {
        return s_recentWinner;
    }

    function getEnternceFee() public view returns (uint256) {
        return i_entraceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }

    function getLotteyState() public view returns (LotteryState) {
        return s_lotteryState;
    }

    function getNumberOfPlayer() public view returns (uint256) {
        return s_players.length;
    }
}
