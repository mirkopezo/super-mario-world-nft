// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./IERC165.sol";

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns(uint256);
    function ownerOf(uint256 tokenId) external view returns(address);
    function setApprovalForAll(address operator, bool approved) external;
    function isApprovedForAll(address owner, address operator) external view returns(bool);
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns(address);
    function transferFrom(address from, address to, uint256 tokenId) external;
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) external;
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}