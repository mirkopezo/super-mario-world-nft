pragma solidity ^0.8.2;

contract ERC721 {
    mapping(address => uint256) internal _balances;
    
    function balanceOf(address owner) public view returns(uint256) {
        require(owner != address(0), "Address of owner cannot be zero!");
        return _balances[owner];
    }
}