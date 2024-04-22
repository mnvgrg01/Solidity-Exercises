// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    mapping(address => uint256) private buyerEscrow;
    mapping(address => uint256) private buyerCool;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(buyerEscrow[msg.sender] == 0, "escrow still exist.");
        buyerCool[msg.sender] = block.timestamp + 3 days;
        buyerEscrow[msg.sender] = msg.value;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(buyerCool[buyer] <= block.timestamp, "still in cooling ");
        (bool ok, ) = msg.sender.call{value: buyerEscrow[buyer]}("");
        require(ok, "call failed");
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        require(buyerCool[msg.sender] >= block.timestamp, "out of 3 days");
        (bool ok, ) = msg.sender.call{value: buyerEscrow[msg.sender]}("");
        require(ok, "call failed");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return buyerEscrow[buyer];
    }
}
