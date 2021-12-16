// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external pure returns(bool);
}