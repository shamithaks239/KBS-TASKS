# KBS-TASK-1
SHAMITHA K S
25IM10062

# PersonalSavingsBank Smart Contract

---

## Overview
The contract PersonalSavingsBank is a private digital vault written in solidity.It allows users to deposit and owner to withdraw Ether with safety contols such as Emeregency freeze, Deposit limits, ownership transfer, time locked withdrawals and audit tracking.

---

## Features:
* Owner only withdrawals
* Time locked funds
* Emergency freeze 
* Tracks total deposits and withdrawals
* Deposit limit per transaction
* Ownership transfer
* Detailed blockchain events
* Safe fallback & receive handling

---

* Solidity Version: pragma solidity ^0.8.31;
* License: MIT

---

## State Variables
* `address public owner;`
  Address of the contract owner.
  
* `uint256 public unlockTime;`  
  Timestamp after which withdrawals are allowed (time-lock).
  
* `bool public frozen;`  
  Indicates whether the vault is frozen or not.

---

## Events
Events allow tracking activity on the blockchain.
* `Deposit(address indexed sender, uint256 amount)`
  Emitted when ETH is deposited into the vault.

* `Withdraw(uint256 amount)`
  Emitted when ETH is withdrawn from the vault.

* `VaultFrozen(bool status)`
  Emitted when the vault is frozen or unfrozen.

* `OwnershipTransferred(address indexed oldOwner, address indexed newOwner)`
  Emitted when contract ownership is transferred.

---

## Constructor
* `constructor(uint256 _lockDuration)`
* Sets the deployer as the owner.
* Locks the vault for a duration specified by the owner.

---

## Modifiers
* `modifier onlyOwner()`  
  Restricts function access to the owner only.

* `modifier notFrozen()`  
  Prevents withdrawals when the vault is frozen.

---

## Functions

* `deposit()`
  Allows users to deposit ETH into the vault.
  Deposit amount must be greater than zero and not exceed `maxDeposit`.
  Deposit amount is added to `totalDeposits`.
  
* `withdraw(uint256 amount)`
  Allows the owner to withdraw ETH after the time-lock expires.
  Withdraw amount must be less than the balance.
  Withdrawals are blocked if the vault is frozen by the owner in the case of any suspicious behaviour.

* `freezeVault()`
  Freezes the vault in case of an emergency.

* `unfreezeVault()`
  Unfreezes the vault and restores withdrawal functionality.

* `transferOwnership(address newOwner)`
  Transfers ownership of the contract to a new address.

* `getBalance()`
  Returns the current ETH balance of the contract.

---

## Receive & Fallback
*  `receive()` 
  The contract accepts ETH transfers without any calldata (send() or transfer()) because of this.
* `fallback()`
  It is executed when no other function signature matches the call data.
  All incoming ETH is counted as a deposit and emits a `Deposit` event.

---

## Ownership Logic

### Owner Initialization
The owner is set during deployment as the address that deploys the contract (msg.sender) via the constructor.
* `owner = msg.sender;`
  
This owner address represents the administrator of the vault.

---

### Owner-Restricted Functions
Certain sensitive operations are restricted to the owner using the `modifier onlyOwner`, which verifies that the caller is the current owner.
The functions can only be executed by the owner:
withdraw(uint256 amount), freezeVault(), unfreezeVault(), transferOwnership(address newOwner) 

Any attempt by a non-owner to call these functions will revert the transaction.

---

### Ownership Transfer

The contract allows the current owner to transfer ownership to a new address using `transferOwnership`.
The previous owner loses all privileged access and the new owner gains full control of owner-restricted functions


* This ownership design provides controlled access to critical functions while preventing unauthorized interactions.

---








