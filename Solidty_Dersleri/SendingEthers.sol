// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank{
    //Amaç insanların istedikleri zaman ether yollayıp istedikleri zaman çekebildikleri banka benzeri bir kontrat tanımlama.
    //Ether gönderilicek fonksiyon ve hesabın'da payable olarak işaretlenmesi gerekli

    mapping (address => uint) balances; //Adreslerin gönderdikleri etherleri tutmak için kullanıcaz.
    

    function sendEthertoContract() payable external { //Kontrat'a ether yollamak için tanımlanan fonksiyon
        // !! Bir fonksiyona etherium göndericeksek PAYABLE ile işaretlememiz gerekli !!
        balances[msg.sender] += msg.value; //Kontratı çağıran kişinin gönderdiği ether kadar bakiyesini arttırdık
    } 

    //Yatırılan mikratı gösteren fonksiyon
    function showBalance() external view returns(uint){
        return balances[msg.sender];
    }

    //Kontrattan kendi cüzdan adresimize parayı geri çekmek için yazılan fonksiyon
    function withDraw(address payable to, uint amount) external {
        require(balances[msg.sender] >= amount, "Yetersiz bakiye."); //Gönderilmek istenen değer kadar parası var mı diye kontrol ediyoruz.
        //Eğer bir hesaba ether göndericeksek o hesabın payable olarak işaretlenmesi gerekli
        //payable(msg.sender).transfer(balances[msg.sender]); -> Bunun yerine
        to.transfer(amount);
        balances[msg.sender] = 0;


        //3 tane Ether gönderme yolu vardır.
        //transfer() fonksiyonu ile yolllamaya çalışırsak geri çevrilir hata verir. (Revert verir)
        //Send() fonksiyon gerçekleştiyse true gerçekleşmezse false döndürür.
        //call() iki tane değer döndürür. (bool, data)  = to.call{value: deger, gas: 12345}("gönderilmek istenen data") şeklinde tanımlanır.

    }

    function showContractBalance() external  view returns (uint) {
        return address(this).balance;
    }


    //Fonksiyon kullanmadan calldata ile fonksiyona ether gönderebiliriz.
    //calldata ile gönderme yaparsak fonksiyon'a değil direkt kontrat'a etherium göndermiş oluruz
    //calldate ile göndermek istersek iki tane özel fonksiyonu olması gerekli.

    uint public receiveCount = 0;
    receive() external payable{ //Ether geldiği zaman kendiliğinden çalışıcak
        receiveCount++;
        balances[msg.sender] += msg.value;
    }

    uint public fallbackCount = 0;
    //receive fonksiyonu olmadığı durumlarda callback receive yerine de çalışır. 
    fallback() external payable { //receive fonksiyonunda farklı olarak bir data 'da gönderebiliriz.
        fallbackCount++;
        balances[msg.sender] += msg.value;
    }

    /*receive ve fallback özet
    eğer receive ve fallback aynı anda varsa, data gönderdiğimizde fallback göndermezsek receive çalışır
    eğer sadece fallback varsa data sız ether göndersek veya data ile birlikte göndersek bile fallback çalışır. */

}