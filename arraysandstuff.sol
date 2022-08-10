//SPDX-License-Identifier:MIT
pragma solidity 0.8.11;
contract InitializeArray
{
    uint[] public a;
    function initialize(uint val,uint x) public
    {
        a.push(val);
    }
}