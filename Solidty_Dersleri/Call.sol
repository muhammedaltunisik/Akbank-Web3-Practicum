// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/*Diğer akıllı kontratlarla etkileşmemizi sağlayan bir method
Çok fazla önerilmeyen low level bir method
Önerilen kullanım: Diğer kontratların fallback() fonksiyonu nu tetklemek yada 1 Eth gördermek için kullanılması
*/

contract Test {
    uint256 public total = 0;
    uint256 public fallbackCalled = 0;
    string public incrementer;

    function inc(uint256 _amount, string memory _incrementer) external returns(uint256){
        total += _amount;
        incrementer = _incrementer;

        return total;
    }

    // fallback() external  payable {
    //     fallbackCalled++;
    // }

    
}

contract Caller {

    function testCall(address _contract, uint256 _amount, string memory _incrementer) external returns(bool,uint256){
        (bool err, bytes memory res) = (_contract).call(abi.encodeWithSignature("inc(uint256, string)", _amount, _incrementer)); //call methodu 2 tane değer döndürür.
        
        //32. satırda ki kod hata verdiği için yazıldı.
        /*Test test1 = Test(payable(_contract));
        uint256 _total = test1.inc(_amount,_incrementer);*/

        uint256 _total = abi.decode(res,(uint256));
        return (err,_total);
    }

    function payToFallback(address _contract) external payable {
        (bool err,) = _contract.call{value: msg.value}(""); //Bu şekilde yaparsak doğrudan diğer fonksiyonun callback fonksiyonu nu tetikler.
    }

}
