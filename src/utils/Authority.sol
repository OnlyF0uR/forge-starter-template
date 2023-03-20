// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.19;

import "../interfaces/IAuthority.sol";
import "../types/AuthGuard.sol";

contract Authority is IAuthority, AuthGuard {
    /* ========== STATE VARIABLES ========== */
    address public override governor;
    address public override guardian;
    address public override treasury;

    address public newGovernor;
    address public newGuardian;
    address public newTreasury;

    /* ========== Constructor ========== */
    constructor(address _governor) AuthGuard(address(this)) {
        governor = _governor;
        emit GovernorPushed(address(0), governor, true);
    }

    /* ========== GOV ONLY ========== */
    function pushGovernor(address _new, bool _ei) external onlyGovernor {
        // Set appropiate value
        if (_ei) governor = _new;
        else newGovernor = _new;
        // Send the event
        emit GovernorPushed(governor, newGovernor, _ei);
    }

    function pushGuardian(address _new, bool _ei) external onlyGuardian {
        // Set appropiate value
        if (_ei) guardian = _new;
        else newGuardian = _new;
        // Send the event
        emit GuardianPushed(guardian, newGuardian, _ei);
    }

    function pushTreasury(address _new, bool _ei) external onlyGuardian {
        // Set appropiate value
        if (_ei) treasury = _new;
        else newTreasury = _new;
        // Send the event
        emit TreasuryPushed(treasury, newTreasury, _ei);
    }

    /* ========== PENDING ROLE ONLY ========== */
    function pullGovernor() external {
        require(msg.sender == newGovernor, "!newGovernor");
        emit GovernorPulled(governor, newGovernor);
        governor = newGovernor;
    }

    function pullGuardian() external {
        require(msg.sender == newGuardian, "!newGuard");
        emit GuardianPulled(guardian, newGuardian);
        guardian = newGuardian;
    }

    function pullTreasury() external {
        require(msg.sender == newTreasury, "!newTreasury");
        emit TreasuryPulled(treasury, newTreasury);
        treasury = newTreasury;
    }
}
