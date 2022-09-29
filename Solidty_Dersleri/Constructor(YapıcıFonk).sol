// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Constructor{
    //Başlangıçta bir defa çalışır daha sonra çalışmaz


    string public tokenName;
    uint public immutable tokenSupply;
    
    

    //Bir kere çalışmasını istediğimiz ve değişmesini istemediğimiz durumlar için kullanırız.
    constructor(string memory _tokenName, uint _tokenSupply){
        tokenName = _tokenName;
        tokenSupply = _tokenSupply;
    }

    //constant, immutable böyle tanımlanan değerler sonradan değiştirilemez

    //constant ile kullanırsak değişken atamaları daha az gas harcar
    //Bir daha değiştirilemez. En başta değerin verilmesi gerekli
    uint public constant x = 20; 

    //Immutable ile kullanırsak değişken atamaları daha az gas harcar
    //Tanımlamasını yaparken ilk değerini atamak zorunda değiliz. Sonrasından const içerisinden değeri atayabiliriz.
    //Eğer tanımlarken ilk değeri atamışsak cons içerisinde değiştiremeyiz.
    // !! Eğer kontratta const yoksa hata verir.
    uint public immutable y = 30; 

    
    

}