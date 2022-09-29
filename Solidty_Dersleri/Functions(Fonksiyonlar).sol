// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Functions{
    uint luckNumber = 7;

    /*
    public:   Sözleşme dağıtıldığında kullanılabilir. Kalıtım alana kullanabilir.
    private:  Sözleşme dağıtıldığında ve kalıtım yoluyla kullanılamz.
    internal: Sözleşme dağıtıldığında kullanılamaz. Kalıtm alan kullanabilir.
    external: Sözleşme dağıtıldığında kullanılabilir. Kalıtım yoluyla kullanılamaz.
    */


    //function - fonksiyonAdi(icerisine alicagi degiskenler) -  erisim belirteci -
    //block'da degisiklik belirteci - return(dondurucegi deger)
    function showLuckNumber() public view returns(uint){
        return luckNumber;
    }

    //view sadece okuma /Global veyahut kontrat fark etmez
    //pure, blocktan okumada yapmıcaz fonksiyon kendi içinde çalışsın demek için

    function setLuckNumber(uint _newLuckNumber) public{
        luckNumber = _newLuckNumber;
    }

    //Birden fazla deger döndürmesi için
    function nothing() public pure returns(uint, bool , bool){
        return(5,true,false);
    }

    //Birden fazla değer döndürme 2
    function nothing2() public  pure returns(uint x, bool y, bool z){
        x = 6;
        y = false;
        z = true;
    }

    //Public -> Hem dışarıdan kullanıcılar hemde kontratlar çağırabilir
    function add(uint a, uint b) public pure returns(uint)
    {
        return a+b;
    }

    //Tanımladığımız fonksiyon 37.satırdaki fonksiyonu çağırabilir
    function add2(uint c, uint d) public pure returns(uint){
        return add(c,d);
    }
    
    //Private -> bu fonksiyona sadece bu kontrat ulaşabilir.

    function privateKey() private pure returns (string memory){
        return "Bu bir private fonksiyondur.";
    }

    //Private fonksiyona disaridan erismek icin
    function callPrivateKey() public pure returns (string memory){
        return privateKey();
    }

    //Internal -> Sadece miras alan kontratlar ve kontrat bu fonksiyonu cagirabilir. Disaridan kullanicilar cagiramaz
    function internalKey() internal pure returns(string memory){
        return "Disaridan cagrilamaz ama Miras alan cagirabilir";
    }
    //Internal fonksiyona disaridan erismek icin
    function callInternalKey() public pure returns(string memory){
        return internalKey();
    }


    //External -> Disarıdan kullanıcılar cagirabilir ama kontrat içerisinde cagrilmaz
    function externalKey() external pure returns(string memory){
        return "Bu bir external fonksiyondur.";
    }


    //Hata verir.
    // function callExternalKey() public pure returns (string memory){
    //     return externalKey();
    // }
}
