// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*İmzayı doğrulama
1. Adım: İmzalanıcak mesaj
2. Adım: hash(imzalanıcak mesaj)
3. Adım: sign(hash(imzalanıcak mesaj), private key) | offchain (zincir dışı, kayıt edilmeyen)
4. Adım: ecrocover(hash(imzalanıcak mesaj), signature) == signer
*/

contract VerifySig{
    function verify (address _signer, string memory _message, bytes memory _sig) external pure returns(bool){
        //ilk adım mesajın alınması
        
        //İkinci  adım mesajı hash fonksiyonu na koymak 
        bytes32 messageHash = getMessageHash(_message);
        
        //Üçüncü adım mesaj hash i ile privete key i birleştirme
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns(bytes32){
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns(address){

        (bytes32 r , bytes32 s , uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns(bytes32 r, bytes32 s, uint8 v){
        require(_sig.length == 65, "invalid signature lenght");

        assembly {
            r :=mload(add(_sig, 32)) //ilk 32 bit
            s :=mload(add(_sig, 64)) //ilk 64 bit
            v :=byte(0,mload(add(_sig, 96))) 
        }

        return (r,s,v);
    }
}