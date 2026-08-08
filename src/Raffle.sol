// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/**
 * @title A sample Raffle Contract
 * @author AB Sattar
 * @notice This contract is for creating a sample raffle contract
 * @dev This implements the Chainlink VRF Version 2.5
 */

contract Raffle {
    /* Errors */
    error Raffle__NotEnoughEth();

    error Raffle__NotEnoughTime();

    uint256 private immutable i_entranceFee;
    // @dev the duration of lottery in seconds
    uint256 private immutable i_interval;

    uint256 private s_lastTimeStamp;
    address[] private s_players;

    /* Events */
    event RaffleEntered(address indexed players);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() public payable {
        if (msg.value >= i_entranceFee) {
            revert Raffle__NotEnoughEth();
        }

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert Raffle__NotEnoughTime();
        }
    }

    /**
     * getter function
     */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
