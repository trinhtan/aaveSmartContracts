describe('View', () => {
  const [owner, attacker, ...otherAccounts] = saddle.accounts;
  const STRATEGY_DAI = {
    baseVariableBorrowRate: '0',
    variableRateSlope1: '40000000000000000000000000',
    variableRateSlope2: '1000000000000000000000000000',
    stableRateSlope1: '0',
    stableRateSlope2: '0',
  };

  test('deploy and read contract', async () => {
    let lendingPoolAddressesProvider,
      feeProvider,
      lendingPoolConfigurator,
      lendingPool,
      lendingPoolCore,
      dai,
      daiReserveInterestRateStrategy;

    lendingPoolAddressesProvider = await deploy('LendingPoolAddressesProvider', [], {
      from: owner,
    });
    feeProvider = await deploy('FeeProvider', [], { from: owner });
    await feeProvider.methods.initialize(lendingPoolAddressesProvider._address).send({
      from: owner,
    });
    await lendingPoolAddressesProvider.methods.setFeeProviderImpl(feeProvider._address).send({
      from: owner,
    });

    await lendingPoolAddressesProvider.methods.setLendingPoolManager(owner).send({
      from: owner,
    });

    lendingPoolConfigurator = await deploy('LendingPoolConfigurator', [], { from: owner });

    await lendingPoolConfigurator.methods.initialize(lendingPoolAddressesProvider._address).send({
      from: owner,
    });

    await lendingPoolAddressesProvider.methods
      .setLendingPoolConfiguratorImpl(lendingPoolConfigurator._address)
      .send({ from: owner });

    lendingPool = await deploy('LendingPool', [], { from: owner });

    await lendingPoolAddressesProvider.methods.setLendingPoolImpl(lendingPool._address).send({
      from: owner,
    });

    lendingPoolCore = await deploy('LendingPoolCore', [], { from: owner });
    await lendingPoolCore.methods.initialize(lendingPoolAddressesProvider._address).send({
      from: owner,
    });

    await lendingPoolAddressesProvider.methods
      .setLendingPoolCoreImpl(lendingPoolCore._address)
      .send({ from: owner });

    dai = await deploy('TestERC20', ['Stable DAI', 'DAI', '18'], { from: owner });

    daiReserveInterestRateStrategy = await deploy(
      'DefaultReserveInterestRateStrategy',
      [
        dai._address,
        lendingPoolAddressesProvider._address,
        STRATEGY_DAI.baseVariableBorrowRate,
        STRATEGY_DAI.variableRateSlope1,
        STRATEGY_DAI.variableRateSlope2,
        STRATEGY_DAI.stableRateSlope1,
        STRATEGY_DAI.stableRateSlope2,
      ],
      { from: owner }
    );

    // console.log(lendingPoolConfigurator._address);

    // console.log(await lendingPoolAddressesProvider.methods.getLendingPoolConfigurator().call());

    await lendingPoolConfigurator.methods
      .initReserve(dai._address, '18', daiReserveInterestRateStrategy._address)
      .send({ from: owner });

    await dai.methods.mint(attacker, '1000000000000000000000').send({ from: owner });

    await dai.methods
      .approve(lendingPoolCore._address, '1000000000000000000')
      .send({ from: attacker });
    await lendingPool.methods
      .deposit(dai._address, '1000000000000000000', '1')
      .send({ from: attacker });
  });
});
