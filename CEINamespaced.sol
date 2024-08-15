// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IChecksEffectsInteractions} from "./ICEI.sol";

/**
 * Re-entrancy example using [EIP7201](https://eips.ethereum.org/EIPS/eip-7201) namespaced storage.
 * Namespaced storage pattern is commonly used by proxies & diamond pattern contracts to
 * avoid storage collisions.
 *
 * Same as basic re-entrancy example [CEI.sol](./CEI.sol) with the following changes:
 * 1. Convert storage to be namespaced
 *
 */
contract ChecksEffectsInteractionsNamespaced is IChecksEffectsInteractions {
    bytes32 constant CEI_STORAGE =
        keccak256(abi.encode(uint256(keccak256("cei.storage")) - 1)) &
            ~bytes32(uint256(0xff));

    /// @custom:storage-location erc7201:cei.storage
    struct CEIStorage {
        mapping(address => uint) balances;
    }

    function getData() internal pure returns (CEIStorage storage ds) {
        bytes32 position = CEI_STORAGE;
        assembly {
            ds.slot := position
        }
    }

    function deposit() public payable {
        mapping(address => uint) storage balances = getData().balances;

        balances[msg.sender] = msg.value;
    }

    function withdraw(uint amount) public {
        mapping(address => uint) storage balances = getData().balances;

        // WARNING: Re-entrancy here
        payable(msg.sender).call{value: amount}("");

        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;
    }
}
