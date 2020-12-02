pragma solidity ^0.5.0;

contract IAToken {
  function balanceOf(address _user) public view returns(uint256);

  function transferOnLiquidation(address _from, address _to, uint256 _value) external;

  function burnOnLiquidation(address _account, uint256 _value) external;

  function mintOnDeposit(address _account, uint256 _amount) external;
}
