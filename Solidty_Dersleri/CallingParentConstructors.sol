// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract S{
    string public name;

    constructor(string memory _name){
        name = _name;
    }
}

contract T{
    string public text;

    constructor(string memory _text){
        text = _text;
    }
}


//Miras alınan sınıfların constructorları ile konuşmanın iki yolu vardır.

//1.Yol
contract U is S("s"),T("t") { //S ve T nin yazılma sırasına göre hangisinin constructor fonksiyonunun önce çalışıcağı belirlenir.

}

//2.Yol
contract V is S, T{
    constructor(string memory _name, string memory _text) S(_name) T(_text){

    }
}


//İki yol aynı anda kullanılabilir.
contract VV is S("new name"),T{

    bool public  isAvaible;
    constructor(string memory _text) T(_text){
        isAvaible = true;
    }

    
}