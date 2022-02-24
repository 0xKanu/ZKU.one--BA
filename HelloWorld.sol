//Introducing License 
//SPDX-License-Identifier: GPL-3.0
//Declaring compiler 
pragma solidity ^0.8.7;

//Defining Contract
contract HelloWorld {
    // Declaring  unsigned integer Variable 
    uint FirstNum;

    //Creating Store Function
    function store(uint _firstNum) public{
        FirstNum = _firstNum;
    }

    //Creating Retrieve Function 
    function retrieve() public view returns(uint){
        return FirstNum;
    }
}
