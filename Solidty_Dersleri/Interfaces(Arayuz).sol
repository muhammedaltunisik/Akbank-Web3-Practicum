// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract EthSender {
    

    function _send(address payable to , uint256 amount) private {
        to.transfer(amount);
    }


    function sendWithStrategy(address strategyAddress) external returns (address,uint){
        /*sendwithStrategy fonksiyonu içerisinde AddressStrategy1 in addresini gönderdiğimiz zaman
        to ve amount değerlerini AddressStrategy1 kontratı altında ki getAddressAndAmount() fonksiyonundan alır.
        Ama sendWithStrategy fonksiyonu nu kullanmak için öncesinden EthSender kontratı içerisine ether göndermek gerekli.*/
        (address payable to, uint256 amount) = AddressStrategy1(strategyAddress).getAddressAndAmount();
        _send(to,amount);
        return (to, amount);
    }

    receive() external payable { }

}

abstract contract Strategy { //Soyut sınıf oluyor. Aşağıda ki iki sınıf da ki getAddressAndAmount fonksiyonlarına ulaşmak için bu sınıfı kullanıcaz.
    function getAddressAndAmount() virtual external pure returns(address payable , uint256);
}


contract AddressStrategy1 {
    uint256 constant ETHER_AMOUNT = 0.1 ether;

    function getAddressAndAmount() external pure returns(address payable , uint256){
        return(payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB),ETHER_AMOUNT);
    }    
}

contract AddressSrategy2 {
    uint256 constant ETHER_AMOUNT = 0.1 ether;

    function getAddressAndAmount() external pure returns(address payable , uint256){
        uint amount = ETHER_AMOUNT * 5;
        return(payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB),amount);
    }   
}