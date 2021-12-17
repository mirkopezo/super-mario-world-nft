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

    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public
        view
        returns (uint256[] memory)
    {
        require(
            accounts.length == ids.length,
            "Accounts and ids array must be same length!"
        );
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 iter = 0; iter < accounts.length; iter++) {
            batchBalances[iter] = balanceOf(accounts[iter], ids[iter]);
        }
        return batchBalances;
    }
}
