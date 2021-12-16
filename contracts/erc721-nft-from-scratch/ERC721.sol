// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Address.sol";
import "./IERC721TokenReceiver.sol";
import "./IERC721.sol";

contract ERC721 is IERC721 {
    using Address for address;

    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _tokenApprovals;

    function balanceOf(address owner) public view override returns(uint256) {
        require(owner != address(0), "Address of owner cannot be zero!");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view override returns(address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token ID does not exist!");
        return owner;
    }

    function setApprovalForAll(address operator, bool approved) public override {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved); 
    }

    function isApprovedForAll(address owner, address operator) public view override returns(bool) {
        return _operatorApprovals[owner][operator];
    }

    function approve(address to, uint256 tokenId) public override {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "You are not owner or approved operator!");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) public view override returns(address) {
        require(_owners[tokenId] != address(0), "Token ID does not exist!");
        return _tokenApprovals[tokenId];
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        address owner = ownerOf(tokenId);
        address approved = getApproved(tokenId);
        require(
            msg.sender == owner || 
            isApprovedForAll(owner, msg.sender) || 
            msg.sender == approved, 
            "You are not owner or approved for this transfer!"
        );
        require(from == owner, "From address is not the owner of token!");
        require(to != address(0), "Recipient address cannot be zero!");
        require(_owners[tokenId] != address(0), "Token ID does not exist!");
        approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public override {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "Receiver not implemented!");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override {
        safeTransferFrom(from, to, tokenId, "");
    }

    function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId,
        bytes memory _data
    ) private returns(bool) {
        if(to.isContract()) {
            return
                IERC721TokenReceiver(to).onERC721Received(
                    msg.sender,
                    from,
                    tokenId,
                    _data
                ) == IERC721TokenReceiver.onERC721Received.selector;
        } else {
            return true;
        }
    }

    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
        return interfaceId == 0x80ac58cd;
    }
}