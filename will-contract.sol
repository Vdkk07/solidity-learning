// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract WillContract {
    uint startTime;
    uint tenYears;
    uint public  lastVisited;
    address public owner;
    address payable public  recipient;

    constructor(address payable  _recipient) {
        owner = msg.sender;
        recipient = _recipient;
        tenYears = 365 days * 10;
        startTime = block.timestamp;
        lastVisited = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlyrecipient(address _recipient) {
        require(recipient == _recipient, "Not recipient");
        _;
    }

    function deposit() public payable onlyOwner {
        lastVisited = block.timestamp;
    }

    function ping() public onlyOwner {
        lastVisited = block.timestamp;
    }

    function claim() public {
        require(block.timestamp - tenYears > lastVisited, "Too early to claim");
        payable(recipient).transfer(address(this).balance);
    }


} 