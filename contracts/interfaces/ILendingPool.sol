pragma solidity ^0.5.0;

/**
@title ILendingPoolAddressesProvider interface
@notice provides the interface to fetch the LendingPoolCore address
 */

contract ILendingPool {

  function redeemUnderlying( address _reserve, address payable _user, uint256 _amount, uint256 _aTokenBalanceAfterRedeem) external;

  function flashLoan(address _receiver, address _reserve, uint256 _amount, bytes memory _params) public;
}
