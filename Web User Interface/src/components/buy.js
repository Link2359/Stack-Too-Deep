Web3=require('web3');

var contract;

function buy(){


    const buytoken = () =>{
    web3 = new Web3(web3.currentProvider);
    var cost= "value of tokens in ethers";
    const address = "Adress of buyer";
    var abi = "abi code of Contract";
    contract=new web3.eth.Contract(abi,address);

    contract.methods.buyTokens(address,cost).send(
        {
            from: address,
            value: cost
        }
    );
    }

    return(
        <button onClick={buytoken}>Buy Tokens</button>
    );
};

export default buy;