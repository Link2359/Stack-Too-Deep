Web3=require('web3');

var contract;

function view(){


    const viewI = () =>{
    web3 = new Web3(web3.currentProvider);
    const address = "Adress of owner";
    var abi = "abi code of Contract";
    contract=new web3.eth.Contract(abi,address);

    contract.methods.viewInvestors().send(
        {
            from: address,
        }
    );
    }

    return(
        <button onClick={viewI}>View the Investors</button>
    );
};

export default view;