pragma solidity ^0.8.3;

contract ShoxToken{
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowence;
    uint public totalSupply = 100000000 * 10 ** 18;
    string public name = "ShoxToken";
    string public symbol = "SX1";
    uint public decimals = 18;
    
    event Tranfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor() {
        balances[msg.sender] = totalSupply;
    }
    
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'balance to low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Tranfer(msg.sender, to, value);
        return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns(bool) { 
         require(balanceOf(msg.sender) >= value, 'balance to low');
         require(allowence[from][msg.sender] >= value, 'allowence to low');
         balances[to] += value;
         balances[from] -= value;
         emit Tranfer(from, to, value);
         return true;
    }
    
    function approve(address spender, uint value) public returns(bool) {
        allowence[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
