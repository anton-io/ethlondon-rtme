// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

// Import the Ownable contract from the OpenZeppelin library for ownership management.
import "@openzeppelin/contracts/access/Ownable.sol";

contract RTME is Ownable {
    // Structure to hold the broadcast message.
    struct Broadcast {
        uint256 broadcastNumber;
        string message;
        uint256 timeBroadcast;
    }

    // Event to log the broadcast message.
    event BroadcastRequest(uint256 broadcastNumber, string message);

    // Array to store all broadcasts.
    Broadcast[] public broadcasts;

    // Fee required to broadcast.
    uint256 private _broadcastFee = type(uint256).max;

    // Constructor to initialize the broadcast fee.
    constructor() Ownable(msg.sender){
    }

    // Function to broadcast a message.
    function broadcast(string memory message) external payable {
        require(msg.value >= _broadcastFee, "Insufficient fee.");

        uint256 broadcastNumberNext = broadcasts.length + 1;
        broadcasts.push(Broadcast({
            broadcastNumber: broadcastNumberNext,
            message: message,
            timeBroadcast: 0
        }));

        emit BroadcastRequest(broadcastNumberNext, message);
    }

    // Function to return the number of broadcast requests.
    function getTotalBroadcasts() public view returns (uint256) {
        return broadcasts.length;
    }

    // Function to return the number of broadcast fee.
    function getBroadcastFee() public view returns (uint256) {
        return _broadcastFee;
    }

    // Function for the owner to set the broadcast time for a message.
    function setTimeBroadcast(uint256 broadcastNumber, uint256 _timeBroadcast) external onlyOwner {
        require(broadcastNumber <= broadcasts.length, "Invalid sequence number.");
        broadcasts[broadcastNumber - 1].timeBroadcast = _timeBroadcast;
    }

    // Function for the owner to set the broadcast fee.
    function setBroadcastFee(uint256 broadcastFee) external onlyOwner {
        _broadcastFee = broadcastFee;
    }

  	/**
	   * Function that allows the owner to withdraw all the Ether in the contract
	   * The function can only be called by the owner of the contract as defined by the isOwner modifier
	   */
  	function withdraw() public onlyOwner {
	  	(bool success, ) = owner().call{ value: address(this).balance }("");
	  	require(success, "Failed to send Ether.");
	  }

    // Must always have an owner.
    function renounceOwnership() public override onlyOwner {
        revert("renounceOwnership has been disabled");
    }
}
