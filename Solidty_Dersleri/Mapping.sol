// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Mapping{
    //Mappingler üzerinde listelerde olduğu gibi gezinemeyiz(For/While) döngüleri ile.

    mapping(address => bool) public registered; //Mappingin tuttuğu değerlerin ilk adresleri değişkenlerin default değerleridir

    function register() public {
        //Icerisinde ki kosul true degilse fonksiyonun cagrilmasını engeller
        require(!registered[msg.sender] , "Buraya hata mesaji yazarakda kullanilabilir."); 
        require(!isRegistered(), "Kullanici daha once kayit olmustur."); //İkinci bur güvenlik olusturmak icin.
        registered[msg.sender] = true;
    }

    function isRegistered() public view returns(bool){
        return registered[msg.sender];
    }

    function deleteRegistered() public {
        require(registered[msg.sender],"Kullanici kayitli degil");
        require(isRegistered(),"Kullanici kayitli degil");
        delete(registered[msg.sender]);
    }
    
}

contract NestedMapping{
    mapping(address => mapping(address => uint)) banaBorcuOlanlar;

    function borcGuncelleme(address _borcuOlan, uint _borcMiktari) public {
        banaBorcuOlanlar[msg.sender][_borcuOlan] += _borcMiktari;
        // her bir adress key ine karşılık (addrese karsi uint degeri tutan) mapping'i tutar.
    }

    function borcGetir(address _borcuOlan) public view returns(uint){
        return  banaBorcuOlanlar[msg.sender][_borcuOlan];
    }

}

contract IterableMapping{
    //Aşağıda ki kod bloğu kullanılırsa mapping üzerinde gezilebilir.
    mapping (address => uint) public balances; //Adresslerin paralarını
    mapping (address => bool) public inserted; //Adreslerin kayıtlı olup olmadığını
    address[] public keys; //Adres listesi

    function set(address _key, uint _val) external {
        balances[_key] = _val;

        if(!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key); //Sıra sıra sisteme giren herkesin keylerini kayıt altında tutuyoruz
        }
    }


    function getSize() public view returns(uint){
        return keys.length;
    }

    function getTotalBalances() external  view returns(uint){ 
        uint totalBalance = 0;
        for(uint256 i = 0; i < getSize(); i++){
            totalBalance = balances[keys[i]];
        }
        return totalBalance;
    }

}
