pragma solidity ^0.5.0;

/**
@title ILendingPoolAddressesProvider interface
@notice provides the interface to fetch the LendingPoolCore address
 */

contract ILendingPoolDataProvider {
  function balanceDecreaseAllowed(address _reserve, address _user, uint256 _amount) external view returns (bool);

  function calculateUserGlobalData(address _user) public view
    returns (
      uint256 totalLiquidityBalanceETH,
      uint256 totalCollateralBalanceETH,
      uint256 totalBorrowBalanceETH,
      uint256 totalFeesETH,
      uint256 currentLtv,
      uint256 currentLiquidationThreshold,
      uint256 healthFactor,
      bool healthFactorBelowThreshold
  );

  function calculateCollateralNeededInETH(
    address _reserve,
    uint256 _amount,
    uint256 _fee,
    uint256 _userCurrentBorrowBalanceTH,
    uint256 _userCurrentFeesETH,
    uint256 _userCurrentLtv
  ) external view returns (uint256);

  function getReserveConfigurationData(address _reserve) external view
    returns (
      uint256 ltv,
      uint256 liquidationThreshold,
      uint256 liquidationBonus,
      address rateStrategyAddress,
      bool usageAsCollateralEnabled,
      bool borrowingEnabled,
      bool stableBorrowRateEnabled,
      bool isActive
  );

   function getReserveData(address _reserve) external view
    returns (
      uint256 totalLiquidity,
      uint256 availableLiquidity,
      uint256 totalBorrowsStable,
      uint256 totalBorrowsVariable,
      uint256 liquidityRate,
      uint256 variableBorrowRate,
      uint256 stableBorrowRate,
      uint256 averageStableBorrowRate,
      uint256 utilizationRate,
      uint256 liquidityIndex,
      uint256 variableBorrowIndex,
      address aTokenAddress,
      uint40 lastUpdateTimestamp
  );


  function getUserAccountData(address _user) external view
    returns (
      uint256 totalLiquidityETH,
      uint256 totalCollateralETH,
      uint256 totalBorrowsETH,
      uint256 totalFeesETH,
      uint256 availableBorrowsETH,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
  );

  function getUserReserveData(address _reserve, address _user) external view
    returns (
      uint256 currentATokenBalance,
      uint256 currentBorrowBalance,
      uint256 principalBorrowBalance,
      uint256 borrowRateMode,
      uint256 borrowRate,
      uint256 liquidityRate,
      uint256 originationFee,
      uint256 variableBorrowIndex,
      uint256 lastUpdateTimestamp,
      bool usageAsCollateralEnabled
  );
}
