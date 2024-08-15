// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IChecksEffectsInteractions} from "./ICEI.sol";

/**
 * Re-entrancy example using a library to implement the logic.
 * Libaries enable better code modularity by decoupling state & logic
 * and avoiding the complexity of inheritance.
 *
 * Same as basic re-entrancy example [CEI.sol](./CEI.sol) with the following changes:
 * 1. Convert logic to library with storage pointers
 */
library ChecksEffectsInteractionsLib {
    function _deposit(mapping(address => uint) storage balances) internal {
        balances[msg.sender] = msg.value;
    }

    function _withdraw(
        mapping(address => uint) storage balances,
        uint amount
    ) internal {
        // WARNING: Re-entrancy here
        payable(msg.sender).call{value: amount}("");

        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;
    }
}

contract ChecksEffectsInteractionsLibContract is IChecksEffectsInteractions {
    mapping(address => uint) balances;

    function deposit() public payable {
        ChecksEffectsInteractionsLib._deposit(balances);
    }

    function withdraw(uint amount) public {
        ChecksEffectsInteractionsLib._withdraw(balances, amount);
    }
}
