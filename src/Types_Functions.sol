pragma solidity ^0.8.0;

contract Memoize {
    // Cache structure: hash of input data -> function selector -> result
    mapping(bytes32 => mapping(bytes4 => bytes)) private cache;
    
    // Track which combinations have been cached
    mapping(bytes32 => mapping(bytes4 => bool)) private cached;
    
    function func1(uint x, uint y) public pure returns (uint) {
        return x + y;
    }
    
    function callWithMemoization(
        bytes4 selector,
        bytes memory data
    ) public returns (bytes memory) {
        // Create a unique key from the input data
        bytes32 key = keccak256(data);
        
        // Check if result is already cached
        if (cached[key][selector]) {
            return cache[key][selector];
        }
        
        // Construct the full call data
        bytes memory fullData = abi.encodePacked(selector, data);
        
        // Make the call
        (bool success, bytes memory result) = address(this).call(fullData);
        require(success, "Function call failed");
        
        // Cache the result
        cache[key][selector] = result;
        cached[key][selector] = true;
        
        return result;
    }
    
    // Helper function to get function selectors
    function getFunc1Selector() public pure returns (bytes4) {
        return this.func1.selector;
    }
    
    // Function to check if a result is cached
    function isCached(bytes memory data, bytes4 selector) public view returns (bool) {
        bytes32 key = keccak256(data);
        return cached[key][selector];
    }
    
    // Function to clear cache for a specific input/selector combination
    function clearCache(bytes memory data, bytes4 selector) public {
        bytes32 key = keccak256(data);
        delete cache[key][selector];
        cached[key][selector] = false;
    }
}