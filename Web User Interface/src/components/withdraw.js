Web3=require('web3');

var contract;

function withdraw(){


    const wInvestement = () =>{

    web3 = new Web3(web3.currentProvider);
    var cost= "value of tokens in ethers";
    const address = "Adress of invester";
    var abi = "abi code of Contract";
    contract=new web3.eth.Contract(abi,address);

    contract.methods.withdrawInvestement(address,cost).send(
        {
            from: address,
            value: cost
        }
    );
    }

    return(
        <button onClick={wInvestement}>Withdraw Your Investement</button>
    );
};

export default withdraw;