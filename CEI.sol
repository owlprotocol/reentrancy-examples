// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IChecksEffectsInteractions} from "./ICEI.sol";

/**
 * Basic re-entrancy example commonly detected by static analyzers.
 *
 * Example code from https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html
 * edited to introduce basic re-entrancy vulnerability by making the following changes
 * 1. Replace `transfer` with low-level `call` (smart contract will be able to execute code to re-enter)
 * 2. Swap lines 12 & 14 (check balance & state update) violating check-effects-interactions pattern
 */
contract ChecksEffectsInteractions is IChecksEffectsInteractions {
    mapping(address => uint) balances;

    function deposit() public payable {
        balances[msg.sender] = msg.value;
    }

    function withdraw(uint amount) public {
        // WARNING: Re-entrancy here
        payable(msg.sender).call{value: amount}("");

        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;
    }
}
