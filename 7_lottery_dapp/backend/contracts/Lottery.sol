// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";

error NotEnougthAmount();
error ReqNotFound();

contract Lottery is VRFConsumerBaseV2 {
    uint256 private immutable enteryFee;
    address payable[] private players;
    uint64 subscriptionId;
    address vrfCoordinator;
    bytes32 gasLane;
    uint32 callbackGasLimit;
    uint16 requestConfirmations;
    uint32 numWords;
    struct RequestStatus {
        bool fulfilled;
        bool exists;
        uint256[] randomWords;
    }
    mapping(uint256 => RequestStatus) public requests;
    VRFCoordinatorV2Interface COORDINATOR;
    uint256[] public requestIds;
    uint256 public lastRequestId;

    event LotteryEnter(address indexed player);
    event RequestSent(uint256 requsetId, uint32 numWords);
    event RequestFulfilled(uint256 requestId, uint256[] randomWords);

    constructor(uint64 _subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
        subscriptionId = _subscriptionId;
    }

    function enterLottery() public payable {
        if (msg.value >= enteryFee) {
            revert NotEnougthAmount();
        }
        players.push(payable(msg.sender));
        emit LotteryEnter(msg.sender);
    }

    function requestRandomWinner(uint256 requsetId) external returns (uint256) {
        requsetId = COORDINATOR.requestRandomWords(
            gasLane,
            subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        requests[requsetId] = RequestStatus({
            randomWords: new uint256[](0),
            exists: true,
            fulfilled: false
        });
        requestIds.push(requsetId);
        lastRequestId = requsetId;
        emit RequestSent(requsetId, numWords);
        return requsetId;
    }

    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) internal override {
        if (requests[_requestId].exists) {
            revert ReqNotFound();
        }
        requests[_requestId].fulfilled = true;
        requests[_requestId].randomWords = _randomWords;
        emit RequestFulfilled(_requestId, _randomWords);
    }

    function getRequestStatus(
        uint256 _requestId
    ) external view returns (bool fulfilled, uint256[] memory randomWords) {
        if (requests[_requestId].exists) {
            revert ReqNotFound();
        }
        RequestStatus memory request = requests[_requestId];
        return (request.fulfilled, request.randomWords);
    }

    function getEntranceFee() public view returns (uint256) {
        return enteryFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return players[index];
    }
}
