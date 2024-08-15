# Re-entrancy Examples

Very simple re-entrancy examples (simple deposit/withdraw) that violate [check-effects-interactions](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html) pattern. Implemented in progressively more challenging ways for static analyzers.

These simple examples are useful for testing out support for libraries & namespaced storage:

1. [Simple Example](./CEI.sol): Basic example that violates the pattern, and introduces a re-entrancy as suggested by [check-effects-interactions](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html)
2. [Library Example](./CEILib.sol): Logic implemented as a library with storage pointers. Contract just calls the library.
3. [Namespaced Storage](./CEINamespaced.sol): Storage using [EIP-7201](https://eips.ethereum.org/EIPS/eip-7201) namespaced storage commonly used by proxies & diamond pattern contracts.
4. [Namespaced Storage Library](./CEINamespacedLib.sol): Combine both examples 2 & 3 using a library with namespaced storage

The key things were looking to test are support for detecting re-entrancy in the following context:

* Libraries that interact with storage pointers (Example 2)
* Contracts with namespaced storage (Example 3)
* Libraries that interact with namespaced storage (Example 4)
