// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract kosulYapilari{
    //Memory ile alınan değişken fonksiyon içerisinde kalır ve blockchaine yüklenmez
    //Solidty'de stringler doğrudan karşılaştırılmaz Hashleri alınarak karşılaştırılır

    // && ve || veya > büyük < kucuk >= büyükesit <= kücükesit
    // == esit != esit degil


    bytes32 private hashedPassword;

    constructor(string memory _password){
        hashedPassword = keccak256(abi.encode(_password));
    }

    function login(string memory password) public view returns(bool){
        if(hashedPassword == keccak256(abi.encode(password))){
            return true;
        }else{ //else if() de arasına eklenebilir.
            return false;
        }
        //return (hashedPassword == keccak256(abi.encode(password))); bu sekilde veya
        //return (hashedPassword == keccak256(abi.encode(password))) ? true : false; seklinde kullanılabilir.
    }

    function returnHased() public view returns(bytes32){
        return hashedPassword;
    }
}

contract kosulYapilari2{
    //if- else if - else yapıları 
    function foo(uint _x) public pure returns(uint){
        if (_x < 10){
            return 0;
        }else if (_x < 20){
            return 1;
        }else {
            return 2;
        }
    }


    /*if (x < 10)
        {
        return 1;
        }

        else {
        return 2;
        } 
    if - else yapısı daha kısa bir şekilde böyle tanımlanabilir.    */
    function foo2(uint _x) public pure returns(uint){
        return _x < 10 ? 1 : 2;
    }

}