module.exports = async () => {
  try {
    const { DAI, LENDING_POOL_CORE } = require('../constant');
    const ERC20 = artifacts.require('ERC20');
    const UseFlashLoan = artifacts.require('UseFlashLoan');
    const ILendingPoolCore = artifacts.require('ILendingPoolCore');

    const useFlashLoanInstance = await UseFlashLoan.deployed();
    const daiInstance = await ERC20.at(DAI);
    const lendingPoolCoreInstance = await ILendingPoolCore.at(LENDING_POOL_CORE);

    console.log('aDAI Address: ' + (await lendingPoolCoreInstance.getReserveATokenAddress(DAI)));

    // process.exit(0);

    // await daiInstance.transfer(useFlashLoanInstance.address, '1000000000000000000');
    console.log(
      'UseFlashLoan - DAI Balance Before Loan: ' +
        parseInt(await daiInstance.balanceOf(useFlashLoanInstance.address))
    );

    await useFlashLoanInstance.flashLoan(
      useFlashLoanInstance.address,
      DAI,
      '1000000000000000000',
      '0x0'
    );

    console.log(
      'UseFlashLoan - DAI Balance After Loan: ' +
        parseInt(await daiInstance.balanceOf(useFlashLoanInstance.address))
    );

    process.exit(0);
  } catch (err) {
    console.log(err);
    process.exit(1);
  }
};
