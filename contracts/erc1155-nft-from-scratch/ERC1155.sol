// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC1155 {
    mapping(uint256 => mapping(address => uint256)) internal _balances;

    function balanceOf(address account, uint256 id)
        public
        view
        returns (uint256)
    {
        require(account != address(0), "Address cannot be zero!");
        return _balances[id][account];
    }
}
