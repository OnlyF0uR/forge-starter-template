// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.19;

import "./types/AuthGuard.sol";

contract Aggregator is AuthGuard {
    address public immutable treasury;

    constructor(address _auth, address _treasury) AuthGuard(_auth) {
        treasury = _treasury;
    }

    receive() external payable {}

    // ... rest of the contract
}
