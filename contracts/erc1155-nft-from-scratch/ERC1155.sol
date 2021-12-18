// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC1155 {
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
    event TransferSingle(
        address indexed _operator,
        address indexed _from,
        address indexed _to,
        uint256 _id,
        uint256 _amount
    );
    event TransferBatch(
        address indexed _operator,
        address indexed _from,
        address indexed _to,
        uint256[] _ids,
        uint256[] _amounts
    );

    mapping(uint256 => mapping(address => uint256)) internal _balances;
    mapping(address => mapping(address => bool)) private _operatorApprovals;

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

    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    function setApprovedForAll(address operator, bool approved) public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function _transfer(
        address from,
        address to,
        uint256 id,
        uint256 amount
    ) private {
        uint256 fromBalance = balanceOf(from, id);
        require(fromBalance >= amount, "You dont have enough tokens!");
        _balances[id][from] = fromBalance - amount;
        _balances[id][to] += amount;
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(
            msg.sender == from || isApprovedForAll(from, msg.sender),
            "You are not the owner or approved for transfer!"
        );
        require(to != address(0), "Recipient address cannot be zero!");
        _transfer(from, to, id, amount);
        emit TransferSingle(msg.sender, from, to, id, amount);
        require(_checkOnERC1155Received(), "Receiver is not implemented!");
    }

    function _checkOnERC1155Received() private pure returns (bool) {
        return true;
    }

    function _checkOnBatchERC1155Received() private pure returns (bool) {
        return true;
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public {
        require(
            msg.sender == from || isApprovedForAll(from, msg.sender),
            "You are not the owner or approved for transfers!"
        );
        require(to != address(0), "Recipient address cannot be zero!");
        require(ids.length == amounts.length, "Arrays must be same length!");
        for (uint256 iter = 0; iter < ids.length; iter++) {
            _transfer(from, to, ids[iter], amounts[iter]);
        }
        emit TransferBatch(msg.sender, from, to, ids, amounts);
        require(_checkOnBatchERC1155Received(), "Receiver is not implemented!");
    }

    function supportsInterface(bytes4 interfaceId)
        public
        pure
        virtual
        returns (bool)
    {
        return interfaceId == 0xd9b67a26;
    }
}
