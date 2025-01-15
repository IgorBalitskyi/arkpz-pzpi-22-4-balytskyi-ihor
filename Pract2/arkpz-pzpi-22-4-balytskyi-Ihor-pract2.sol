pragma solidity ^0.8.0;


//Приклад 1
contract SimpleContract {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}
//Код після рефакторингу
contract SimpleContract {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}


contract Factory {
    function createContract(address _owner) public returns (SimpleContract) {
        return new SimpleContract(_owner);
    }
}


//Приклад 2
contract Example {
    function process(uint value) public pure returns (string memory) {
        if (value > 0) {
            if (value < 100) {
                return "Valid range";
            } else {
                return "Value too high";
            }
        } else {
            return "Value too low";
        }
    }
}


//Код після рефакторингу
contract Example {
    function process(uint value) public pure returns (string memory) {
        if (value <= 0) return "Value too low";
        if (value >= 100) return "Value too high";
        return "Valid range";
    }
}


//Приклад 3
contract Payment {
    function processPayment(string memory method) public pure returns (string memory) {
        if (keccak256(abi.encodePacked(method)) == keccak256("credit")) {
            return "Credit payment processed";
        } else if (keccak256(abi.encodePacked(method)) == keccak256("debit")) {
            return "Debit payment processed";
        } else {
            return "Unknown payment method";
        }
    }
}

//Код після рефакторингу
abstract contract Payment {
    function processPayment() public virtual pure returns (string memory);
}

contract CreditPayment is Payment {
    function processPayment() public pure override returns (string memory) {
        return "Credit payment processed";
    }
}

contract DebitPayment is Payment {
    function processPayment() public pure override returns (string memory) {
        return "Debit payment processed";
    }
}


//Приклад 4
// Вихідний код
contract Token {
    string public name;
    uint public totalSupply;

    constructor(string memory _name, uint _totalSupply) public {
        if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("USDT"))) {
            name = "Tether";
        } else if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("ETH"))) {
            name = "Ethereum";
        } else {
            name = _name;
        }
        totalSupply = _totalSupply;
    }
}

contract Payment {
    function processPayment(address user, uint amount) public returns (string memory) {
        if (user != address(0)) {
            if (amount > 0) {
                if (amount < 100) {
                    return "Low Payment";
                } else {
                    return "Payment Successful";
                }
            } else {
                return "Invalid Amount";
            }
        } else {
            return "Invalid User";
        }
    }
}


// Код після рефакторингу:
contract Token {
    string public name;
    uint public totalSupply;

    constructor(string memory _name, uint _totalSupply) public {
        name = _name;
        totalSupply = _totalSupply;
    }
}

contract TokenFactory {
    function createToken(string memory _name, uint _totalSupply) public pure returns (Token) {
        if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("USDT"))) {
            return new Token("Tether", _totalSupply);
        } else if (keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("ETH"))) {
            return new Token("Ethereum", _totalSupply);
        } else {
            return new Token(_name, _totalSupply);
        }
    }
}


contract Payment {
    function processPayment(address user, uint amount) public pure returns (string memory) {
        if (user == address(0)) {
            return "Invalid User";
        }
        if (amount <= 0) {
            return "Invalid Amount";
        }
        if (amount < 100) {
            return "Low Payment";
        }
        return "Payment Successful";
    }
}
