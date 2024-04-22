// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    mapping(address => uint256) private balance;
    uint256 public lastDeposit;
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return balance[user];
    }

    function depositEther() external payable {
        balance[msg.sender] += msg.value;
        lastDeposit = block.timestamp;
        /// add code here
    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        require(amount <= balance[msg.sender], " not enough bal");
        require(block.timestamp >= lastDeposit + 1 weeks, "still in coolinng");
        balance[msg.sender] -= amount;
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "call failed");
    }
}
