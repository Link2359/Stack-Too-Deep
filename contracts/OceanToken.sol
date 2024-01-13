// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract OceanToken is ERC20, ERC20Burnable {
    address payable owner;
    uint256 public OwnerTokens;
    uint256 public cap;
    uint256 public value;
    address[] private buyers;
    address[] private investors;
    mapping(address => uint256) private tokenHolders;
    mapping(address => uint256) private tokenInvestors;

    modifier OnlyOwner() {
        require(msg.sender == owner , "Error");
        _;
    }
    modifier  OnlyInvestor(){
        require(tokenInvestors[msg.sender]!=0, "Error");
        _;
    }

    function tokenvalue(uint tokens) private {
            value = (50*(10**18)/tokens);
    }
    function etherstobesent(uint amount) view public returns(uint){
        return value*amount;
    }
    constructor(
        uint256 _cap,
        uint256 amount
    ) payable ERC20("OceanToken", "OCT") {
        owner = payable(msg.sender);
        cap = _cap;

        require(totalSupply() + amount <= cap, "Cap exceeded");
        _mint(msg.sender, amount);
        OwnerTokens = OwnerTokens + amount;
        tokenvalue(OwnerTokens);
    }


    function viewInvestors() public view OnlyOwner returns (address[] memory) {
        address[] memory allInvestors = new address[](investors.length);

        for (uint256 i = 0; i < investors.length; i++) {
            allInvestors[i] = investors[i];
        }

        return allInvestors;
    }

    function investTokens(uint256 amount)
        public
        payable
    {
        require(msg.value == value * amount, "Incorrect Ether value");
        owner.transfer(msg.value);
        _mint(owner, amount);
        OwnerTokens = OwnerTokens + amount;
        investors.push(msg.sender);
        tokenInvestors[msg.sender] = amount;
        tokenvalue(OwnerTokens);
    }

    function investedtokens()
        public
        view
        returns (uint256)
    {
        require(tokenInvestors[msg.sender]!=0,"no investment");
        return tokenInvestors[msg.sender];
    }

    function withdrawInvestment(address payable Tokeninvestor, uint256 amount)
        public
        payable
        OnlyInvestor
    {
        require(
            tokenInvestors[Tokeninvestor] >= amount,
            "insufficient investment"
        );
        tokenInvestors[Tokeninvestor] -= amount;
        Tokeninvestor.transfer(msg.value);
        if (tokenInvestors[Tokeninvestor] == 0) {
            for (uint256 i = 0; i < investors.length; i++) {
                if (investors[i] == Tokeninvestor) {
                    investors[i] = investors[investors.length - 1];
                    investors.pop();
                    break;
                }
            }
        }
    }

    function sellTokens(address payable seller, uint256 amount) public payable {
        require(
            tokenHolders[seller] >= amount,
            "Insufficient amount of tokens"
        );

        _burn(seller, amount);
        _mint(owner, amount);
        OwnerTokens = OwnerTokens + amount;
        tokenHolders[seller] -= amount;
        seller.transfer(msg.value);
        tokenvalue(OwnerTokens);
    }

    function buyTokens(uint256 amount) public payable {
        require(
            msg.sender.balance >= value * amount,
            "Insufficient ethers in account"
        );
        require(OwnerTokens >= amount, "Insufficient amount of tokens");

        owner.transfer(msg.value);

        _burn(owner, amount);
        _mint(msg.sender, amount);
        buyers.push(msg.sender);
        tokenHolders[msg.sender] = amount;
        OwnerTokens = OwnerTokens - amount;
        tokenvalue(OwnerTokens);
    }
}