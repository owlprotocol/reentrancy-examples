/**
 * Interface for Check Effects Interactions re-entrancy example
 */
interface IChecksEffectsInteractions {
    function deposit() external payable;

    function withdraw(uint amount) external;
}
