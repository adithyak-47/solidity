//SPDX-License-Identifier:MIT
pragma solidity 0.8.11;
contract bank
{
    mapping(address=>uint) private balances;
    function deposit() external payable
    {
        balances[msg.sender]+=msg.value;
    }
    function withdraw(address payable addr,uint amt) public payable
    {
        require(balances[addr]>=amt,"Insufficient funds!!");
        (bool sent,bytes memory data)=addr.call{value: amt}("");
        require(sent,"Could not withdraw");
        balances[msg.sender]-=amt;
    }
    function getBalance() public view returns(uint)
    {
        return address(this).balance;
    }
}