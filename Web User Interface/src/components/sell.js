Web3=require('web3');

var contract;

function sell(){


    const selltoken = () =>{
    web3 = new Web3(web3.currentProvider);
    var cost= "value of tokens in ethers";
    const address = "Adress of seller";
    var abi = "abi code of Contract";

    contract=new web3.eth.Contract(abi,address);

    contract.methods.sellTokens(address,cost).send(
        {
            from: address,
            value: cost
        }
    );
    }

    return(
        <button onClick={selltoken}>Sell Tokens</button>
    );
};

export default sell;