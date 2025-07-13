// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Memoize} from "../src/Types_Functions.sol";

contract MemoizeTest is Test {
    Memoize memoize;

    function setUp() public {
        memoize = new Memoize();
    }

    function testFuncEquality(uint256 x) public {
        // Call func1 directly to get the expected result
        uint expected = memoize.func1(x);
        // Call func2 to get the memoized result
        uint actual = memoize.func2(x);
        // Assert they are equal
        assertEq(actual, expected, "func1 and func2 results differ");
    }
}
