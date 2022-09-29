// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FeeCollector{
    address public owner;
    uint256 public balance;

    constructor(){          
        owner = msg.sender; //0x7931403CA3A546E734BaCA02A7506E246e145FD1
    }

    receive() payable external {
        balance += msg.value;
    }

    function withdraw(uint256 amount, address payable destAddr) public{
        require(msg.sender == owner,"Only owner can withdraw"); //Sadece kontrat sahibi işlem yapabilsin diye aldığımız önlem
        require(amount <= balance,"Insufficient funds");        //Kontratın sahip olduğu değer girilen değerden yüksek veya eşit mi diye aldığımız önlem
        destAddr.transfer(amount);                              //Verilen adrese transfer yapma
        balance -= amount;                                      //toplam bakiyeyi gönderilen adres kadar azalatma
    } 

}
