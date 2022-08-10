//SPDX-License-Identifier:MIT
pragma solidity 0.8.11;
contract first
{
    address public last;

  function recive() external payable{
      last=msg.sender;
  }
  function getBalance() public view returns(uint)
  {
      return address(this).balance;
  }
  function payment(address payable addr) public payable
  {
      (bool sent,bytes memory data)=addr.call{value: 1 ether}("");
      require(sent,"Error!!");
  }

}