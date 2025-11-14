// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Auction{
    address payable public seller;//seller

    address highestBidder; //user create max bets

    uint public highestBid;

    uint endTime;

    mapping (address => uint) chargeback;

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
        if(highestBid != 0){
            //last highestbidder need to take back money
            chargeback[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

   function withdraw() public returns (bool) {
    uint amount = chargeback[msg.sender];
    if (amount > 0) {
        payable(msg.sender).transfer(amount); // Reverts on failure
        chargeback[msg.sender] = 0;
        return true;
    }
    return false; // No funds to withdraw
    }
    function endAuction() public {
        require(isEnded(), "Auction not ended");
        require(msg.sender == seller, "Only seller can end auction");
        seller.transfer(highestBid); // Reverts on failure
    }
}