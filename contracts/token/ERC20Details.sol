pragma solidity ^0.4.11;

/**
 * @title ERC20 Details
 * @dev Implements the optional details of an ERC20 token: name, symbol, and decimals.
 */
contract ERC20Details {
  string public name;
  string public symbol;
  uint8 public decimals;

  /**
   * @dev The ERC20Details constructor sets the values of the public variables.
   * @param _name The name of the token.
   * @param _symbol The symbol of the token.
   * @param _decimals The number of decimals that should be used in the representation of token amounts.
   */
  function ERC20Details(string _name, string _symbol, uint8 _decimals) {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
  }
}
