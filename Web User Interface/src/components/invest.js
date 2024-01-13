Web3=require('web3');

var contract;

function invest(){


    const itoken = () =>{
    web3 = new Web3(web3.currentProvider);
    var cost= "value of tokens in ethers";
    const address = "Adress of investor";
    var abi = "abi code of Contract";
    contract=new web3.eth.Contract(abi,address);

    contract.methods.investTokens(address).send(
        {
            from: address,
            value: cost
        }
    );
    }

    return(
        <button onClick={itoken}>Invest Tokens</button>
    );
};

export default invest;