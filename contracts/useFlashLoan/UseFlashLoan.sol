pragma solidity ^0.5.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

import "../interfaces/ILendingPoolAddressesProvider.sol";
import "../interfaces/ILendingPool.sol";
import "../libraries/EthAddressLib.sol";
import "../interfaces/IUniswapRouter.sol";

contract UseFlashLoan is Ownable {

    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    ILendingPoolAddressesProvider public addressesProvider;
	ILendingPool public lendingPool;
	IUniswapRouter public uniswapRouter;

	uint256 public SuccessfulTxCount;

    constructor(address _provider, address _uniswapRouter) public {
        addressesProvider = ILendingPoolAddressesProvider(_provider);
		lendingPool = ILendingPool(addressesProvider.getLendingPool());
		uniswapRouter = IUniswapRouter(_uniswapRouter);
    }

    function () external payable {
    }

    function transferFundsBackToPoolInternal(address _reserve, uint256 _amount) internal {

        address payable core = addressesProvider.getLendingPoolCore();

        transferInternal(core,_reserve, _amount);
    }

    function transferInternal(address payable _destination, address _reserve, uint256  _amount) internal {
        if(_reserve == EthAddressLib.ethAddress()) {
            //solium-disable-next-line
            _destination.call.value(_amount)("");
            return;
        }

        IERC20(_reserve).safeTransfer(_destination, _amount);


    }

    function getBalanceInternal(address _target, address _reserve) internal view returns(uint256) {
        if(_reserve == EthAddressLib.ethAddress()) {

            return _target.balance;
        }

        return IERC20(_reserve).balanceOf(_target);

    }

	function flashLoan(address _receiver, address _reserve, uint256 _amount, bytes calldata params) external onlyOwner {
		lendingPool.flashLoan(_receiver, _reserve, _amount, params);
	}

	function executeOperation(address _reserve, uint256 _amount, uint256 _fee, bytes calldata _params) external {
		transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));
	}
}
