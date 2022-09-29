// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//1.Yöntem için bu kontrat.
contract Interact {
    address public caller;
    mapping (address =>uint) public counts;
    

    //Tüm adreslerin kontratı kaç kere çağırdığını görücez.
    function callThis() external {
        caller = msg.sender;
        counts[msg.sender] += 1;
    }
}

//2.Yöntem için bu kontrat.
contract Pay {
    mapping(address => uint256) public usersBalances;

    function payEther(address _payer) external payable {
        usersBalances[_payer] += msg.value;
    }
}


/* msg.sender -> A kontratını çağırdığı zaman A'nın aldığı msg.sender değeri , normal msg.sender değerine eşit olur
  A -> B kontratını çağırırsa bu sefer B'nin aldığı msg.sender değeri, A kontratının addressi olur

    msg.sender -> A (Mesaj yollayan msg.sender) -> B (Mesaj yollayan A adresi)  
  
*/


contract Caller {
    //1.Yöntem
    Interact interact; //Yukarı da tanımlı kontrattı interact adlı bir değişken tanımladık.

    constructor(address _interactContract) {
        /*
        İlk önce interact kontratını deploy edicez. Sonra oluşan kontrat adresini kullanarak Caller kontratını deploy edicez.
        address bilgisi bu yüzden gerekli.
        */
        interact = Interact(_interactContract); 
    }

    function callInteract() external {
        interact.callThis(); 
    }

    function readCaller()  external view returns(address) {
        return interact.caller(); //hepsini parantezle çağırmak gerek
    }

    function readCallerCount() public view returns(uint256){
        return interact.counts(msg.sender);
    }



    //2. Yöntem

    function payTopay(address _payAddress) public payable {
        Pay pay = Pay(_payAddress); //Pay kontratının adresini yukarıda ki gibi vermemiz gerekli
        pay.payEther{value: msg.value}(msg.sender); //payEther fonksiyonuna msg.value değerinide gönderdik.

        //ikinci yol
        //Pay(_payAddress).payEther{value: msg.value}(msg.sender);
    }

    //Fosnkiyon hata verir çünkü interact fonksiyonunda receive ve fallback fonksiyonları yok
    function sendEtherByTransfer() public payable {
        payable(address(interact)).transfer(msg.value);
    }
}