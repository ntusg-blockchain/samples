pragma solidity >=0.5.0;

abstract contract ICentralBank {
	function GetExchangeRate(uint16 code) public virtual;
}

abstract contract ICurrencyExchange {
	function setExchangeRate(uint32 n_exchangeRate) public virtual;
}

// This contract implements 'IBank' interface.
contract CentralBank is ICentralBank {

	// Modifier that allows public function to accept all external calls.
	modifier alwaysAccept {
		// Runtime function that allows contract to process inbound messages spending
		// its own resources (it's necessary if contract should process all inbound messages,
		// not only those that carry value with them).
		tvm.accept();
		_;
	}

	// State variable storing the currency code.
	uint16 currencyCode;

	// This function receives the code of currency and returns to the sender exchange rate
	// via calling a callback function.
	function GetExchangeRate(uint16 code) public override alwaysAccept {
		// Save parameter <code> in the state variable <currencyCode>
		currencyCode = code;
		// Cast address of caller to ICurrencyExchange interface and
		// call its 'setExchangeRate' function.
		ICurrencyExchange(msg.sender).setExchangeRate(code * 16);
	}

}
