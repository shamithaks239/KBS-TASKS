// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract PersonalSavingsBank {

    // STATE VARIABLES

    address public owner;

    uint256 public totalDeposits;
    uint256 public totalWithdrawals;

    uint256 public maxDeposit = 10 ether;
    uint256 public unlockTime;

    bool public frozen;

    // EVENTS

    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(uint256 amount);
    event VaultFrozen(bool status);
    event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);

    // CONSTRUCTOR 

    constructor(uint256 _lockDuration) {
        owner = msg.sender;
        unlockTime = block.timestamp + _lockDuration;
    }

    // MODIFIERS 

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier notFrozen() {
        require(!frozen, "Vault is frozen");
        _;
    }

    // FUNCTIONS 

    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than zero");
        require(msg.value <= maxDeposit, "Deposit exceeds max limit");

        totalDeposits += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external onlyOwner notFrozen {
        require(block.timestamp >= unlockTime, "Funds are still time-locked");
        require(amount > 0, "Amount must be greater than zero");
        require(amount <= address(this).balance, "Insufficient balance");

        totalWithdrawals += amount;

        payable(owner).transfer(amount);

        emit Withdraw(amount);
    }

    function freezeVault() external onlyOwner {
        frozen = true;
        emit VaultFrozen(true);
    }

    function unfreezeVault() external onlyOwner {
        frozen = false;
        emit VaultFrozen(false);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        address oldOwner = owner;
        owner = newOwner;

        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // RECEIVE & FALLBACK 

    receive() external payable {
        totalDeposits += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    fallback() external payable {
        totalDeposits += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}