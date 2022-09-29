// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Errors{
    //Errors kullanarak bazı fonksiyonların çalışmasını engellicez.
    //Bu fonksiyonların çalışmalarını engelleyen hata durumları ile ilgili dışarıya mesaj göndericez.
    
    //reqire() => kullanici kaynaklı hataları engellemek içi 
    //revert() => hataları yakalamak ve fonksiyonları durdurmak için
    //assert() => Asla yanlış olmaması gereken kod tabanlı hataları engellemek için (ÖRN: uint bir degisken max degerine geldiğinde +1 yaparsak en düşük değerine geçer.) 
    

    error ExceedingAmount(address user , uint256 exceedingAmount);
    error Deny(string reason);

    uint256 public totalBalance;
    mapping (address => uint256 ) public usersBalance;

    receive() external payable {
        revert("Kontrat'a direkt para gonderimi yapilamaz."); //Hata mesajı olarak içindeki string'i yazdırır
        //revert Deny("Kontrat'a direkt para gonderimi yapilamaz.");
    }

    fallback() external  payable {
        revert Deny("Kontrat'a direkt para gonderimi yapilamaz."); //Hata mesajı olarak Deny içerisine verilen değerleri döndürür.
    }

    function pay() noZero(msg.value) external payable  {
        require(msg.value == 1 ether, "Only payments in 1 ether"); //Sadece 1 etherlik ödeme yapılmasını istiyoruz
        
        totalBalance += 1 ether;
        usersBalance[msg.sender] += 1 ether;
    }

    function withDraw(uint _amount) noZero(_amount) external  {
        uint256 initalBalance = totalBalance;

        //require(usersBalance[msg.sender] >= _amount, "Yatirdiginizdan daha fazla para cekemezsiniz"); aşağıda ki if koşuluna karşılık gelir

        if(usersBalance[msg.sender] < _amount ){ //Revert ile hatayı ayıklayıp istenen fonksiyonun gerceklesmemesini saglıyoruz.
            //revert("Yatirdiginizdan fazlasini cekemezsiniz"); seklinde veya 10.satır da tanımlandığı sekliyle aşağıda ki gibi kullanılabilir.
            //Bu şekilde kullanırsak string hata mesajı yerine içerisine verdiğimiz değerleri bize geri döndürdüğü bir hata mesajı alabiliriz.
            revert ExceedingAmount(msg.sender, _amount - usersBalance[msg.sender]);
        }

        totalBalance -=  _amount;
        usersBalance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        //Çekme işlemi yapıldığında her zaman totalBalance initalBalanceden küçük olur.
        //Ama kod kaynaklı bir hata olmasın diye assert yerleştirdik. (Bknz. 10.satır)
        assert(totalBalance < initalBalance); 
    }

    modifier noZero(uint256 _amount){ //Sıfır ether gönderilmesini önlemek için
        require(_amount != 0, "Sifir ether gonderilemez");
        _;
    }



}