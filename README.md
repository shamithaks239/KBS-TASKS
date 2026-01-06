# KBS-TASK-1
SHAMITHA K S
25IM10062

PRIVATE DIGITAL VAULT

The contract PersonalSavingsBank is a private digital vault written in solidity.It allows users to deposit and owner to withdraw Ether with safety contols such as Emeregency freeze, Deposit limits, ownership transfer, time locked withdrawals and audit tracking.

### FEATURES:
Owner only withdrawals
Time locked funds
Emergency freeze 
Tracks total deposits and withdrawals
Deposit limit per transaction
Ownership transfer
Detailed blockchain events
Safe fallback & receive handling


Solidity Version: pragma solidity ^0.8.31;
License: MIT


### State Variables
- `uint256 public unlockTime;`  
  Timestamp after which withdrawals are allowed (time-lock).
  
- `bool public frozen;`  
  Indicates whether the vault is frozen or not.


### Events
Events allow tracking activity on the blockchain.


### Constructor
Sets the deployer as the owner.
Locks the vault for a specified duration by the owner.


### Modifiers
- `modifier onlyOwner()`  
  Restricts function access to the owner only.

- `modifier notFrozen()`  
  Prevents withdrawals when the vault is frozen.












