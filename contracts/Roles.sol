pragma solidity ^0.4.11;

library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }

  function add(Role storage role, address addr) internal {
    role.bearer[addr] = true;
  }

  function remove(Role storage role, address addr) internal {
    role.bearer[addr] = false;
  }

  function check(Role storage role, address addr) internal {
    require(role.bearer[addr]);
  }
}
