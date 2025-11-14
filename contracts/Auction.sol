// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Auction{
    address payable public seller;//seller

    address highestBidder; //user create max bets

    uint public highestBid;

    uint endTime;

    constructor(
    address payable _seller,
    uint auction_interval
    ) {  
    seller = _seller;
    endTime = block.timestamp + auction_interval;
    }
    
    function isEnded() public view returns (bool) {
    return block.timestamp > endTime; // Also replaced `now` (deprecated) with `block.timestamp`
    }
    function makeBid() public payable {
        require(!isEnded(), "Auction ended");
        require(msg.value >highestBid, "Invalid Bid");

        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}