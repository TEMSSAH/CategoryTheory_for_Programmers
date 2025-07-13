// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Memoize} from "../src/Types_Functions.sol";

contract MemoizeTest is Test {
    Memoize memoize;
    
    function setUp() public {
        memoize = new Memoize();
    }
    
    function testFuncEquality(uint256 x, uint256 y) public {
        // Prevent overflow by limiting the input values
        vm.assume(x <= type(uint256).max - y);
        // Call func1 directly to get the expected result
        uint directCall = memoize.func1(x, y);
        
        // Prepare data for memoized call
        bytes4 selector = memoize.getFunc1Selector();
        bytes memory data = abi.encode(x, y);
        
        // Call func1 through memoization to get the memoized result
        bytes memory result = memoize.callWithMemoization(selector, data);
        uint memoizedCall = abi.decode(result, (uint));
        
        // Assert they are equal
        assertEq(memoizedCall, directCall, "Direct and memoized func1 results differ");
    }
}