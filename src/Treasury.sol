// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./interfaces/ITreasury.sol";
import "./types/AuthGuard.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract Treasury is ITreasury, AuthGuard {
    constructor(address _auth) AuthGuard(_auth) {}

    receive() external payable {}

    function withdrawNative(uint256 _amount) external onlyGovernor {
        require(_amount <= address(this).balance, "Not enough funds");
        payable(msg.sender).transfer(_amount);
    }

    function withdrawToken(address _token, uint256 _amount) external onlyGovernor {
        require(_amount <= IERC20(_token).balanceOf(address(this)), "Not enough funds");
        IERC20(_token).transfer(msg.sender, _amount);
    }
}
