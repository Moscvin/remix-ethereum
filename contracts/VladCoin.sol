// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


//CryptoCurrency "VladCoin"
contract VladCoin{

    address owner;
    mapping(address => uint) public  balances; //balances all users

    constructor() public {
        owner = msg.sender; //who created a contract is owner

    }
    //create VladCoin
    function createCoin(address reciever,uint amount) public {
        require(msg.sender == owner,"Only owner can create coins");
        balances[reciever] +=amount;
    }
    function sendCoin(address reciever, uint amount) public{
        //check if seneder have amount
        require(balances[msg.sender] >= amount, "Insufficient balance!!!");

        balances[msg.sender] -=amount;

        balances[reciever] += amount;
    }


}