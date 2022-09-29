// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Çağırmanın 2 yolu vardır. Direkt veya super fonksiyonu ile 

contract E{
     event Log(string _name);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo(); //Miras alınan kontratın fonksiyonu nu çağırdık
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); //Miras alınan kontratın fonksiyonu nu çağırdık
    }
}

contract G is E{
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo(); //Miras alınan kontratın fonksiyonu nu çağırdık
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar(); //Miras alınan kontratın fonksiyonu nu çağırdık
    }
}

//İki sınıfı kullanarak bir sınıf türettik.
contract H is F , G{
    function foo() public virtual override(F,G) { //İki sınıftan türettiğimiz için hangi sınıfın fonksiyonunu override edğiceğimiz söylememiz gerekli.
        F.foo(); 
    }

    function bar() public virtual  override(F,G){
        super.bar(); //super ile yaparsak miras aldığı tüm kontratların bar fonksiyonarlını kullanır. Yani F ve G kontratlarının bar() fonksiyonları çağrılır.
    }
}