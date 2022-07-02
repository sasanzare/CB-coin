// SPDX-License-Identifier: GPL-3.0v
pragma solidity >=0.5.0 <0.9.0;

contract Codebox{

    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }

    // MAKE NEW COINS AND SEND THEM TO AN ADDRESS
    // ONLY THE OWNER CAN SEND THESE COINS
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;

    }

    //SEND ANY AMOUNT OF COINS
    //TO AN EXISTING ADDRESS

    error insufficientBalance(uint requested, uint available );

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

}