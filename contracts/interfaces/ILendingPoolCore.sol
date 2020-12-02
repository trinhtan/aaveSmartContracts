pragma solidity ^0.5.0;
// import "../libraries/CoreLibrary.sol";
import "../libraries/InterestRateMode.sol";

/**
@title ILendingPoolAddressesProvider interface
@notice provides the interface to fetch the LendingPoolCore address
 */

contract ILendingPoolCore {
  function initReserve( address _reserve, address _aTokenAddress, uint256 _decimals, address _interestRateStrategyAddress) external;

  function removeLastAddedReserve(address _reserveToRemove) external;

  function enableBorrowingOnReserve(address _reserve, bool _stableBorrowRateEnabled) external;

  function disableBorrowingOnReserve(address _reserve) external;

  function enableReserveAsCollateral(address _reserve, uint256 _baseLTVasCollateral, uint256 _liquidationThreshold, uint256 _liquidationBonus) external;

  function disableReserveAsCollateral(address _reserve) external;

  function enableReserveStableBorrowRate(address _reserve) external;

  function disableReserveStableBorrowRate(address _reserve) external;

  function activateReserve(address _reserve) external;

  function getReserveTotalLiquidity(address _reserve) public view returns (uint256);

  function deactivateReserve(address _reserve) external;

  function freezeReserve(address _reserve) external;

  function unfreezeReserve(address _reserve) external;

  function setReserveBaseLTVasCollateral(address _reserve, uint256 _ltv) external;

  function setReserveLiquidationThreshold(address _reserve, uint256 _threshold) external;

  function setReserveLiquidationBonus(address _reserve, uint256 _bonus) external;

  function setReserveDecimals(address _reserve, uint256 _decimals) external;

  function setReserveInterestRateStrategyAddress(address _reserve, address _rateStrategyAddress) external;

  function refreshConfiguration() external;

  function getReserveNormalizedIncome(address _reserve) external view returns (uint256);

  function getReserveATokenAddress(address _reserve) public view returns (address);

  function updateStateOnDeposit( address _reserve, address _user, uint256 _amount, bool _isFirstDeposit) external;

  function transferToReserve(address _reserve, address payable _user, uint256 _amount) external payable;

  function getReserveAvailableLiquidity(address _reserve) public view returns (uint256);

  function updateStateOnRedeem(address _reserve, address _user, uint256 _amountRedeemed, bool _userRedeemedEverything) external;

  function transferToUser(address _reserve, address payable _user, uint256 _amount) external;

  function isReserveBorrowingEnabled(address _reserve) external view returns (bool);

  function isUserAllowedToBorrowAtStable(address _reserve, address _user, uint256 _amount) external view returns (bool);

  function updateStateOnBorrow(address _reserve, address _user, uint256 _amountBorrowed, uint256 _borrowFee, InterestRateMode.Mode _rateMode) external returns (uint256, uint256);

  function getUserBorrowBalances(address _reserve, address _user) public view returns (uint256, uint256, uint256);

  function getUserOriginationFee(address _reserve, address _user) external view returns (uint256);

  function updateStateOnRepay(address _reserve, address _user, uint256 _paybackAmountMinusFees, uint256 _originationFeeRepaid, uint256 _balanceIncrease, bool _repaidWholeLoan) external;

  function transferToFeeCollectionAddress(address _token, address _user, uint256 _amount, address _destination) external payable;

  function getUserCurrentBorrowRateMode(address _reserve, address _user) public view returns (InterestRateMode.Mode);

  function updateStateOnSwapRate(address _reserve, address _user, uint256 _principalBorrowBalance, uint256 _compoundedBorrowBalance, uint256 _balanceIncrease, InterestRateMode.Mode _currentRateMode) external returns (InterestRateMode.Mode, uint256);

  function getUserCurrentStableBorrowRate(address _reserve, address _user) external view returns (uint256);

  function getReserveCurrentLiquidityRate(address _reserve) external view returns (uint256);

  function getReserveCurrentStableBorrowRate(address _reserve) public view returns (uint256);

  function updateStateOnRebalance(address _reserve, address _user, uint256 _balanceIncrease) external returns (uint256);

  function getUserUnderlyingAssetBalance(address _reserve, address _user) public view returns (uint256);

  function setUserUseReserveAsCollateral(address _reserve, address _user, bool _useAsCollateral) public;

  function updateStateOnFlashLoan(address _reserve, uint256 _availableLiquidityBefore, uint256 _income, uint256 _protocolFee) external;

  function getReserves() external view returns (address[] memory);

  function getReserveIsActive(address _reserve) external view returns (bool);

  function getReserveIsFreezed(address _reserve) external view returns (bool);

  function getUserBasicReserveData(address _reserve, address _user) external view returns (uint256, uint256, uint256, bool);

  function getReserveConfiguration(address _reserve) external view returns (uint256, uint256, uint256, bool);

  function isUserUseReserveAsCollateralEnabled(address _reserve, address _user) external view returns (bool);

  function getReserveDecimals(address _reserve) external view returns (uint256);

  function getReserveIsStableBorrowRateEnabled(address _reserve) external view returns (bool);

  function getReserveLiquidationBonus(address _reserve) external view returns (uint256);

  function getReserveInterestRateStrategyAddress(address _reserve) public view returns (address);

  function getReserveTotalBorrowsStable(address _reserve) external view returns (uint256);

  function getReserveTotalBorrowsVariable(address _reserve) external view returns (uint256);

  function getReserveCurrentVariableBorrowRate(address _reserve) external view returns (uint256);

  function getReserveCurrentAverageStableBorrowRate(address _reserve) external view returns (uint256);

  function getReserveUtilizationRate(address _reserve) public view returns (uint256);

  function getReserveLiquidityCumulativeIndex(address _reserve) external view returns (uint256);

  function getReserveVariableBorrowsCumulativeIndex(address _reserve) external view returns (uint256);

  function getReserveLastUpdate(address _reserve) external view returns (uint40 timestamp);

  function getUserVariableBorrowCumulativeIndex(address _reserve, address _user) external view returns (uint256);

  function getUserLastUpdate(address _reserve, address _user) external view returns (uint256 timestamp);

  function isReserveUsageAsCollateralEnabled(address _reserve) external view returns (bool);

  function updateStateOnLiquidation(
    address _principalReserve,
    address _collateralReserve,
    address _user,
    uint256 _amountToLiquidate,
    uint256 _collateralToLiquidate,
    uint256 _feeLiquidated,
    uint256 _liquidatedCollateralForFee,
    uint256 _balanceIncrease,
    bool _liquidatorReceivesAToken
  ) external;

  function liquidateFee(address _token, uint256 _amount, address _destination) external payable;
}
