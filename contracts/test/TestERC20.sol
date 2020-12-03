pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";

contract TestERC20 is ERC20, ERC20Detailed, ERC20Mintable {
  constructor(string memory name, string memory symbol, uint8 decimals) ERC20Detailed(name, symbol, decimals) ERC20Mintable() public {
  }
}
