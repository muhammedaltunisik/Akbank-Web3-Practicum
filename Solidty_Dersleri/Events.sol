// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract structs{

    

    
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

    //Eventler kontrat içersinde olan şeyleri ui 'a iletmemize yarar (PyQuit'de olduğu gibi). Kontrat içerisinde hiçbir işe yaramaz.
    //Tanımlama => event EventAdı(Event'in alıcağı parametreler) 

    event OrderCrated(uint _orderId, address indexed _customer); 
    //Parametreleri dışarı çıkıcak işlemleri gösterir
    //Eğer alıcağı parametreleri indexed olarak belirlersek sonrasında blockchain ağı üzerinden sorgulamasını(bulabiliriz) yapabilir
    //blockchain ağı üzerinde kayıtlı kalır
    event ZipChanged(uint256 _orderId, string _zipCode);

    constructor()
    {
        owner = msg.sender;
    }

    function creatOrder(string memory _zipCode, uint256[] memory _products) checkProducts(_products) external returns(uint256){
        Order memory order;
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken; 
        orders.push(order);

        emit OrderCrated(orders.length - 1, msg.sender); //Eventi tetiklemek için kullanılır

        return orders.length - 1;
    }

    //Siparis durumlarını degistirmek icin
    function advanceOrder(uint256 _orderId) checkOrderId(_orderId) onlyOwner external{
        

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

    function getOrder(uint256 _orderId) checkOrderId(_orderId) external view returns(Order memory) {
        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) checkOrderId(_orderId) external{
        
        Order storage order = orders[_orderId];
        require(order.customer == msg.sender, "You are not the owner");
        order.zipCode = _zip;
        emit ZipChanged(_orderId, _zip);
    }


    
    modifier checkProducts(uint256[] memory _products) { 
        require(_products.length > 0, "No Products.");
        _; 
    }

    modifier checkOrderId(uint256 _orderId){
       
        require(_orderId < orders.length, "Not a valid order ID");
        _;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "You are not authorized.");
        _;
    }


}