// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStorage {

    uint256 public storedValue;

    event ValueChanged(uint256 newValue);

    // Store a value
    function setValue(uint256 _value) public {
        storedValue = _value;
        emit ValueChanged(_value);
    }

    // Update the value
    function updateValue(uint256 _value) public {
        storedValue = _value;
        emit ValueChanged(_value);
    }

    // Retrieve the value
    function getValue() public view returns (uint256) {
        return storedValue;
    }

    // Increment the value
    function increment() public {
        storedValue++;
        emit ValueChanged(storedValue);
    }
    // Decrement the value
    function decrement() public {
        require(storedValue > 0, "Value cannot be negative");
        storedValue--;
        emit ValueChanged(storedValue);
    }
}
