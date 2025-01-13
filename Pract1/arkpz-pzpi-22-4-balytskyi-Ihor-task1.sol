pragma solidity ^0.8.0;


//Приклад 1
// Поганий приклад
contract X {
    uint a;

    function f(uint b) public {
        a = b;
    }
}

// Гарний приклад
contract Wallet {
    uint256 balance;

    function setBalance(uint256 newBalance) public {
        balance = newBalance;
    }
}


//Приклад 2
// Поганий приклад
uint256 total = 100; // Задаємо змінну total рівну 100

// Гарний приклад
// Максимальна кількість токенів, які можуть бути випущені
uint256 maxSupply = 1000000;


//Приклад 3
// Поганий приклад
function transfer(address to,uint256 amount) public {
    require(balance >= amount,"Insufficient balance");
    balance-=amount;to.transfer(amount);
}

// Гарний приклад
function transfer(address to, uint256 amount) public {
    require(balance >= amount, "Insufficient balance");
    balance -= amount;
    to.transfer(amount);
}


//Приклад 4
// Поганий приклад
function processTransaction(address to, uint256 amount) public {
    require(balance >= amount, "Insufficient balance");
    balance -= amount;
    to.transfer(amount);
    emit TransferCompleted(to, amount);
}


// Гарний приклад
function validateBalance(uint256 amount) private view {
    require(balance >= amount, "Insufficient balance");
}

function executeTransfer(address to, uint256 amount) private {
    balance -= amount;
    to.transfer(amount);
}

function processTransaction(address to, uint256 amount) public {
    validateBalance(amount);
    executeTransfer(to, amount);
    emit TransferCompleted(to, amount);
}


//Приклад 5
//before formating
contract Example{uint a;function f(uint b)public {a=b;}}

// after formating
contract Example {
    uint256 value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }
}