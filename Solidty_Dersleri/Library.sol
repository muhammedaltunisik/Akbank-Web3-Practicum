// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


library Math{ //Tanımı 
    //Sürekli kullanıcağımız özellikleri fonksiyonları oluşturur
    //Bu sayede başka kontratlarda da kullanabiliriz.


    function plus(uint x, uint y) public pure returns(uint){
        return x + y;
    }

    function minus(uint x, uint y) public pure returns(uint){
        return x - y;
    }

    function multi(uint x, uint y) public pure returns(uint){
        return x * y;
    }

    function divided(uint x, uint y) public pure returns(uint){
        require(y != 0,"Sifira bolunemez");
        return uint(x / y);
    }

    function min(uint x, uint y) public pure returns(uint){
        if(x > y)
            return y;
        else
            return x;
    }
}

contract Library{
    using Math for uint; //Bu sekilde kullanırsak (uint olarak tanımlanmış şeylerden sonra Math kütüphanesini kullanabiliriz)
    //Ornek uint x;
    //x.plus(y); == Math.plus(x,y);

    function trial(uint x, uint y) public pure returns(uint top, uint cikar, uint carp, uint bol, uint min){
        //Kütüphane adından sonra . koyarak değerlere erişebiliriz.
        top = Math.plus(x,y);
        cikar = Math.minus(x,y);
        carp = Math.multi(x,y);
        bol = Math.divided(x,y);
        min = Math.min(x,y);
    }
}


library Human{
    
    struct Person{
        uint age;
    }

    function birthday(Person storage _person) public{
        _person.age += 1;
    }

    function showAge(Person storage _person) public view returns(uint){
        return _person.age;
    } 

    
}

contract HumanContract{
    mapping (uint => Human.Person) people;
    Human.Person public p = Human.Person(20);
    
    function x() public {
        people[0] = p;
    }

    function newYear() public{
        Human.birthday(people[0]); //mapping'de kayıtlı ilk insanın yasisini arttirir. 
        Human.birthday(people[1]);
    }

    function show() public view returns(uint, uint){
        return (Human.showAge(people[0]) , people[1].age);
    }
}