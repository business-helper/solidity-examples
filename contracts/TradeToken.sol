// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ERC20Token {
    string public name;
    mapping(address => uint256) public balances;
    
    function mint() public {
        // balances[msg.sender] ++;
        balances[tx.origin] ++;
    }
}

contract TokenA {
    mapping(address => uint256) public balances;
    address payable wallet;
    address public token;
    
    event Purchase(
        address _buyer,
        uint256 _amount
    );
    
    constructor(address payable _wallet, address _token) {
        wallet = _wallet;
        token = _token;
    }
    
    fallback() external payable {
        buyToken();
    }
    
    receive() external payable {
        buyToken();
    }
    
    function buyToken() public payable{
        ERC20Token _token = ERC20Token(address(token));
        _token.mint();
        // balances[msg.sender] += 1;
        wallet.transfer(msg.value);
        // emit Purchase(msg.sender, 1);
    }
} 