// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

contract HotelRoom{
    address payable public owner;
    enum Statuses { FREE, NOTFREE}
    Statuses currentStatus;
    
    event occypy(address _hirer, uint _value);
    
    
    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.FREE;
    }
    
    modifier onlyWhileFree{
        require(currentStatus == Statuses.FREE, "Sorry, we are not free now");
        _;
    }
    
    modifier cost(uint _amount){
        require(msg.value >= _amount, "Not enough fund");
        _;
    }
    
    receive() external payable onlyWhileFree cost(2 ether) {
        currentStatus = Statuses.NOTFREE;
        owner.transfer(msg.value);
        emit occypy(msg.sender, msg.value);
    }
}

