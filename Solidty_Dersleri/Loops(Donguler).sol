// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Donguler{

    uint[15] public number0;
    uint[15] public number1;
    uint[] public number2;

    function listByFor() public {
        uint256[15] memory nums;
        //continue ve break diger dillerdeki gbidir.

        for(uint i = 0; i<nums.length; i++)
            nums[i] = i; //Tek satırlık bir iş yapılıcaksa parantez koymaya gerek yok
        number0 = nums;
    }

    function getArr0() public view returns(uint[15] memory){
        return number0;
    }

    function listByWhile() public{
        uint counter = 0;
        while(counter < number1.length){
            number1[counter] = counter;
            counter++;
        }
    }

    function getArr1() public view returns(uint[15] memory){
        return number1;
    }

    function listByDoWhile() public{
        uint counter = 0;
        do{
            counter++;
            number2.push(counter);
        }while(counter < 5);
    }

    function getArr2() public view returns(uint[] memory){
        return number2;
    }
}