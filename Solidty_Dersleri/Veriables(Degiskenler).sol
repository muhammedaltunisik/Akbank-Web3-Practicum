 // SPDX-License-Identifier: MIT
 //^ bundan önceki sürümleride kapsar demektir
 pragma solidity ^0.8.0;


contract Veriables{
    //Kontart başlangıcı
    

    //Sabit degiskenler  (type-name = deger; şeklinde tanımlanır)
    bool trueOrFalse = true; //Mantık degiskenleri , Varsayılan Deger: False
    int sayi = 12; //Intager sayı değeri için /int256 ya eşittir aralik -> (-2^256 to 2^256) , Varsayılan Değer: 0
    int8 sayi2 = 12; //-2^8 to 2^8
    uint sayi3 = 123; //İsaretli sayılar(-negatif olamaz) 0 to 2^256
    address myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; //20 byte adresi tutar , Varsayılan Değer: 0x00000000000000000000000000 
    bytes32 name1 = "isim"; //stringlerin bir alt kolu, Varsayılan değer: 0x000000000000000000000000000000000000000000
    //byte lar degerleri hexadecimal olarak tutar

    //int değişkenlerin maks ve min değerlini bulmak için
    int public minInt = type(int).min;
    int public maxInt = type(int).max;


    //Dinamik degiskenler
    string name2 = "muhammed"; 
    bytes name3 = "muhammed32"; //Aralık vermediğimiz için dinamik oldu
    
    //icerisinde tutulucak veri- arrayAdi = [veriler,veri,veri]
    uint[10] dizi = [1,2,3,4,5,6,7,8,9,10]; //Kaç değer tutucağı tanımlanırken kararlaştırılır.
    uint[] array = [1,2,3,4,6]; //aray[0] degeri = 1

    //verilen anahtara karşılık bi değer tutucak
    mapping(uint => string) public list; //örnekte intlere karsilik gelen stringler tutucak
    //list[0] = "muhammed"; //list degiskeninde 3'e karsilik muhammed gelir.



    //Kullanıcılar tarafından olusturulan degiskenler
    struct Human{
        uint ID;
        string name;
        uint age;
    }
    /*Human adında içerinde 3 farklı veri tutan bir veri olusturudk*/

    Human insan1 = Human(1111,"Muhammed",23);

    /*Human insan2;
    insan2.ID = 1112131241;
    insan2.name = "Mahmut";
    insan2.age = 31;*/

    enum trafik_isiklari{
        RED,
        YELLOW,
        GREE
    }


    // 1 wie = 1;
    // 1 ether = 10^18 wei;
    // 1 gwei = 19^9 wie; //Etherium donusum birimleri

    // 1 = 1 seconds;
    // 1 minutes = 60 seconds;
    // 1 hours = 60 minutes; = 3600 seconds;
    

    //Solidity'de 3 çeşit değiken vardır.

    //Yerel: Blockchain'de saklanmaz, Fonksiyon içerisinde bildirilir.
    //Durum(State): Fonksiyon dışında bildirilir, Blokchain'de saklanur.
    //Global: Blockchain ile ilgili değişkenler (Herkesin erişebildiği)
    //block.number , block.difficulty, block.gaslimit, block.timestamp vb.
    //msg.sender -> kontratı çağıran kişi


    /* ******************************************* */
    // Erişim belirteçler

    string public name; //Dısarıdan herkes erisebilir.

    



}