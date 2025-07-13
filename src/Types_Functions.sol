pragma solidity ^0.8.0;
contract Memoize {
	mapping (bytes32 => uint) private cache;
	function func2(uint x) external returns (uint){
		bytes32 key = keccak256(abi.encode(x));
		if (cache[key] == 0){
			cache[key] = func1(x);
		}
		return cache[key];
	}
	function func1(uint x) public pure returns (uint){
		return x;
	}
}