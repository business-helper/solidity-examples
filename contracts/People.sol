// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract People {
    Person[] public people;
    uint public peopleCount = 0;
    mapping(uint => Person) public peopleMap;
    address owner;
    uint256 openingTime = 1626338798;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyWhileOpen() {
        require(block.timestamp >= openingTime);
        _;
    }

    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }
    
    constructor() {
        owner = msg.sender;    
    }
    
    function addPerson(string memory _firstName, string memory _lastName) public onlyOwner onlyWhileOpen {
        incrementCount();
        people.push(Person(peopleCount, _firstName, _lastName));
        peopleMap[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
}
