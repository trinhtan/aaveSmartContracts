/** @format */
const { ether, time } = require('@openzeppelin/test-helpers');
// const { accounts, contract } = require('@openzeppelin/test-environment');
const { expect, use } = require('chai');

const LendingPoolAddressesProvider = artifacts.require('LendingPoolAddressesProvider');
const FeeProvider = artifacts.require('FeeProvider');
const LendingPoolConfigurator = artifacts.require('LendingPoolConfigurator');
const LendingPoolCore = artifacts.require('LendingPoolCore');
const LendingPool = artifacts.require('LendingPool');

contract('Attack', ([owner, attacker, alice, bob]) => {
  let lendingPoolAddressesProvider,
    feeProvider,
    lendingPoolConfigurator,
    lendingPool,
    lendingPoolCore;

  before(async () => {
    lendingPoolAddressesProvider = await LendingPoolAddressesProvider.new({ from: owner });

    feeProvider = await FeeProvider.new({ from: owner });
    await feeProvider.methods['initialize(address)'](lendingPoolAddressesProvider.address, {
      from: owner,
    });

    await lendingPoolAddressesProvider.methods['setFeeProviderImpl(address)'](feeProvider.address, {
      from: owner,
    });
    await lendingPoolAddressesProvider.methods['setLendingPoolManager(address)'](owner, {
      from: owner,
    });

    lendingPoolConfigurator = await LendingPoolConfigurator.new({ from: owner });

    await lendingPoolConfigurator.methods[
      'initialize(address)'
    ](lendingPoolAddressesProvider.address, { from: owner });

    await lendingPoolAddressesProvider.methods[
      'setLendingPoolConfiguratorImpl(address)'
    ](lendingPoolConfigurator.address, { from: owner });

    // lendingPool = await LendingPool.new({ from: owner });
    // await lendingPool.methods['initialize(address)'](lendingPoolAddressesProvider.address, {
    //   from: owner,
    // });

    // await lendingPoolAddressesProvider.methods['setLendingPoolImpl(address)'](lendingPool.address, {
    //   gas: 9999999999,
    //   from: owner,
    // });

    // lendingPoolCore = await LendingPoolCore.new({ from: owner });
    // await lendingPoolCore.methods['initialize(address)'](lendingPoolAddressesProvider.address, {
    //   from: owner,
    // });
  });

  it('check', async () => {});
});
