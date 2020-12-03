require('dotenv').config();
const UseFlashLoan = artifacts.require('UseFlashLoan');
const { DAI } = require('../constant.js');

module.exports = async function (deployer) {
  try {
    await deployer.deploy(
      UseFlashLoan,
      '0x1c8756FD2B28e9426CDBDcC7E3c4d64fa9A54728' /* aave */,
      '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D' /* uniswapRouter*/
    );
  } catch (err) {
    console.log(err);
  }
};
