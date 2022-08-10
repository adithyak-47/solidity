//SPDX-License-Identifier:MIT
pragma solidity 0.8.11; 
contract Auction
{
    event Start();
    event End(address HighestBidder,uint Highestbid);
    event Bid(address indexed sender,uint amount);
    event Withdraw(address indexed bidder,uint amount);
    address payable public seller;
    bool public started;
    bool public ended;
    uint public Highestbid;
    address public HighestBidder; 
    uint public endAt;
    mapping(address=>uint) public bids;
    constructor()
    {
        seller=payable(msg.sender);
    }
    function start(uint StartingBid) external
    {
        require(!started,"Auction has already begun!");
        require(msg.sender==seller,"Auction was not started");
        Highestbid=StartingBid;
        started=true;
        endAt= block.timestamp + 2 days;
        emit Start();
    }
    function end() external{
        require(started,"Auction has not started");
        require(block.timestamp>=endAt,"Auction period has not yet expired");
        require(!ended,"Auction period has expired");
        ended=true;
        emit End(HighestBidder,Highestbid);
    }
    function bid() external payable
    {
        require(started,"Auction has not yet started");
        require(block.timestamp<endAt,"Auction has ended");
        require(msg.value>Highestbid);
        if (HighestBidder!=address(0))
        {
            bids[HighestBidder]+=Highestbid;
        }
        HighestBidder=msg.sender;
        Highestbid=msg.value;
        emit Bid(HighestBidder,Highestbid);
    }
    function withdraw() external payable
    {
        uint bal=bids[msg.sender];
        bids[msg.sender]=0;
        (bool sent,bytes memory data)=payable(msg.sender).call{value:bal}("");
        require(sent,"Could not withdraw");
        emit Withdraw(msg.sender,bal);
    }

}