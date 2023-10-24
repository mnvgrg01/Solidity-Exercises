// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IsSorted {
    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order) or false if its not.
     */
    function isSorted(uint256[] calldata arr) public view returns (bool) {
        // your code here
        uint256 a;
        uint256 b;
        if (arr.length < 1) {
            return false;
        }
        for (uint256 i = 1; i < arr.length; i++) {
            a = arr[i - 1];
            b = arr[i];
            if (a > b) {
                return false;
            }
        }
        return true;
    }
}
