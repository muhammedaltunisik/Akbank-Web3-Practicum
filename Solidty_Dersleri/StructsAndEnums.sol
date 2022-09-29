// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract structs{

    //Siparis durumlari icin
    //Sadece belirli sayi değerlerini alabilen yapılardır. 
    //Verilen degerler disinda bisi dondurmezler

    //Modifiers -> bir fonksiyonun çalışmasından veya çağrılmasından önce veya sonra 
    //istediğimiz özellikleri yapmasını sağlamaya yarar.
    enum Status{
        Taken, //0 Alındı
        Preparing, // 1 Hazırlanıyor
        Boxed, // 2 Kutulandı
        Shipped // 3 Kargolandır
    }

    //Kendimize göre ayarlayabildiğimiz karmaşık veri tipidir
    struct Order{
        address customer; //Alıcının adresi
        string zipCode; //Alıcının zip kodu
        uint256[] products; //Alınan işyalar
        Status status; //Alınan eşyanın durumu ile ilgili status.
    }

    Order[] public orders;
    address public owner;

    constructor()
    {
        owner = msg.sender;
    }

    function creatOrder(string memory _zipCode, uint256[] memory _products) public returns(uint256){
        require(_products.length > 0, "No Products.");

        Order memory order;
        //Struct degiskenlerine erismek icin
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken; //-> enums degerlerine ulasmak için kullanılır Enums.deger
        orders.push(order);

        // orders.push(
        //     Order({
        //         customer: msg.sender,
        //         zipCode: _zipCode,
        //         products: _products,
        //         status: Status.Taken
        //     })
        // );


        //orders.push(Order(msg.sender,_zipCode,_products,Status.Taken)); 

        //Yukarıda ki üç yöntemde kullanılabilir

        return orders.length - 1;
    }

    //Siparis durumlarını degistirmek icin
    function advanceOrder(uint256 _orderId) external{
        require(owner == msg.sender, "You are not authorized.");
        require(_orderId < orders.length, "Not a valid order ID");

        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped,"Order is already shipped");
        if(order.status == Status.Taken){
            order.status = Status.Preparing;
        }else if(order.status == Status.Preparing){
            order.status = Status.Boxed;
        }else if(order.status == Status.Boxed){
            order.status = Status.Shipped;
        }
    }

    function getOrder(uint256 _orderId) external view returns(Order memory) {
        require(_orderId < orders.length, "Not a valid order ID");

        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) external{
        require(_orderId < orders.length, "Not a valid order ID");
        Order storage order = orders[_orderId];
        require(order.customer == msg.sender, "You are not the owner");
        order.zipCode = _zip;
    }
}