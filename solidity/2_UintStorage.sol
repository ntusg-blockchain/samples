pragma solidity >=0.5.0;

// Remote contract interface.
abstract contract Storage {
	function storeValue(uint value) public virtual;
}

// This contract implements 'Storage' interface.
contract UintStorage is Storage {

	// Modifier that allows public function to accept all external calls.
	modifier alwaysAccept {
		// Runtime function that allows contract to process inbound messages spending
		// its own resources (it's necessary if contract should process all inbound messages,
		// not only those that carry value with them).
		tvm.accept();
		_;
	}

	// State variables:
	uint value;                // storage for a uint value;
	address client_address;    // last caller address.

	// A function to be called from another contract.
	// This function receives parameter 'n_value' from another contract and
	// saves this value in the state variable 'value' of this contract.
	// Also this function saves the address of the contract that called 'storeValue' function
	// in the state variable 'client_address'.
	function storeValue(uint n_value) public override alwaysAccept {
		value = n_value;
		client_address = msg.sender;
	}

}
