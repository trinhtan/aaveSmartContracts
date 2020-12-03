require('dotenv').config();

var HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  contracts_directory: './contracts/useFlashLoan',
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      // gas: 5000000,
      // gasPrice: 5e18,
    },
    ropsten: {
      provider: function () {
        return new HDWalletProvider(
          process.env.OPERATOR_PRIVATE_KEY,
          'https://ropsten.infura.io/v3/'.concat(process.env.INFURA_PROJECT_ID)
        );
      },
      gas: 8000000,
      network_id: 3,
    },

    rinkeby: {
      provider: function () {
        return new HDWalletProvider(
          process.env.OPERATOR_PRIVATE_KEY,
          'https://rinkeby.infura.io/v3/'.concat(process.env.INFURA_PROJECT_ID)
        );
      },
      gas: 10000000,
      network_id: 4,
    },
  },
  rpc: {
    host: 'localhost',
    post: 8080,
  },
  mocha: {
    useColors: true,
  },
  compilers: {
    solc: {
      version: '0.5.17',
    },
  },
};
