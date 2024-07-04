// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address public owner;
    uint public totalOrders;
    
    struct Customer {
        string name;
        address addr;
        uint orderCount;
    }
    
    mapping(address => Customer) public customers;
    mapping(address => bool) public isCustomer;
    
    event NewCustomerRegistered(address customerAddress, string customerName);
    event OrderPlaced(address customerAddress, uint orderNumber);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    constructor() {
        owner = msg.sender;
        totalOrders = 0;
    }
    
    function registerCustomer(string memory _name) public {
        customers[msg.sender] = Customer(_name, msg.sender, 0);
        isCustomer[msg.sender] = true;
        
        emit NewCustomerRegistered(msg.sender, _name);
    }
    
    function placeOrder() public {
        require(isCustomer[msg.sender], "You must register as a customer before placing an order.");
        
        customers[msg.sender].orderCount += 1;
        totalOrders += 1;
        
        emit OrderPlaced(msg.sender, customers[msg.sender].orderCount);
    }
    
    function getTotalOrders() public view returns (uint) {
        return totalOrders;
    }
}
