pragma solidity ^0.5.0;

/**
@title ILendingPoolAddressesProvider interface
@notice provides the interface to fetch the LendingPoolCore address
 */

contract ILendingPoolParametersProvider {
  function getMaxStableRateBorrowSizePercent() external returns (uint256);
  function getRebalanceDownRateDelta() external returns (uint256);
  function getFlashLoanFeesInBips() external pure returns (uint256, uint256);
}
