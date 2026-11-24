pragma solidity ^0.8.20;

contract SimpleStorage {

    uint256 public storedValue;

    event ValueChanged(uint256 newValue);

    function setValue(uint256 _value) public {
        storedValue = _value;
        emit ValueChanged(_value);
    }

    function updateValue(uint256 _value) public {
        storedValue = _value;
        emit ValueChanged(_value);
    }
    function getValue() public view returns (uint256) {
        return storedValue;
    }

    function increment() public {
        storedValue++;
        emit ValueChanged(storedValue);
    }
    function decrement() public {
        require(storedValue > 0, "Value cannot be negative");
        storedValue--;
        emit ValueChanged(storedValue);
    }
}
