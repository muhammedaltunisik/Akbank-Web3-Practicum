// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//virtual => Bu kontrat miras alınırsa miras alan tarafından değiştirilebilir demektir. Fonksiyonları virtual olarak işaretlersek değiştirilebilir olur.
contract A {
    uint public x;
    uint public y;

    function setX(uint _x) virtual public   returns(uint){
        x = _x;
        return x;
    }

    //Fonksiyon internal olarak işaretlenirse miras alan fonksiyon KontratAdi.FonksiyonAdi şeklinde üst kontrat değerlerine erişebilir.
    function setY(uint _y) virtual public   returns(uint){
        y = _y;
        return y;
    }
}

/*override => miras aldığımız virtual fonksiyonu değiştirmek istiyorsak, funcitoin MirasAlınanFonkAdı( parametre ) erişimBelirteci override {} şeklinde
tanımlamamız gerekli*/
//Birden fazla contrat miras alınabilir.

contract B is A { //A kontratı miras olarak alındı ve içerdiği tüm değerler fonksiyonlar bu kontrat tarafından da kullanılabilir.
    uint public z;

    function setZ(uint _z) public returns(uint) {
        z = _z;
        return z;
    }

    function setX(uint _x) public override  returns(uint ){
       x = _x * 2;
       return x;
    }

    
}


/*FARKLI ÖRNEK*/
contract Human {
    function sayHello() public pure virtual returns(string memory){
        return "ITU blockchain'e uye olmak icin ";
    }
}

contract SuperHuman is Human{
    
    function sayHello() public pure override returns(string memory){
        return "Selamlar ITU blockchain uyesi";
    }

    function welcomeMsg(bool isMember) public pure returns(string memory){
        return isMember ? sayHello(): super.sayHello(); //(Kontrat.fonksiyonAdi) ile diğer kontrat fonksiyonuna erişebiliriz veya (super.fonksiyonAdi)ile erişilebilir.
    }

}


//Dışarıdan (reddit vb.) yerlerden kontrat miras almak için
//import kontratAdresininURL sini yazarak alabiliriz.

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol"; şeklinde veya
//import "@openzeppelin/contracts/access/Ownable.sol"; şeklinde import edilebilir.
