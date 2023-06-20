import React, {useState, useEffect} from 'react';
import Web3 from 'web3';
import './App.css';
import ABI from './Abi.json';

function App() {
  const [account, setAccount] = useState([]);
  const [smartContract, setSmartContract] = useState(null);
  const [readValue, setReadValue] = useState("");
  const [amount, setAmount] = useState();
  const [reciever, setReciever] = useState("");

  const web3 = new Web3 ( Web3.givenProvider || "https://sepolia.infura.io/v3/0d381a998b1e418f98ef69b7b3d29ed5")

  const connectWallet = async () => {
    if(window.ethereum) {
      try {
        window.ethereum.request({ method: "eth_requestAccounts" });
        const accounts = await web3.eth.getAccounts();
        const message = "Hello, welcome to the Lestonz App! Do you want to connect your wallet this App?";
        await web3.eth.personal.sign(message, accounts[0], " ");

        setAccount(accounts);
      } catch (error) {
        console.log(error);
      }
    } else {
      alert("Please Download Metamask!");
    }
  } 

  const connectSmartContract= async () => {
    try {
        const contractABI = ABI;
        const contractAddress = "0x2462d6b96582E7793C4a575a3d5b44BD4d77A03A";

        const contract = new web3.eth.Contract(contractABI, contractAddress);
        setSmartContract(contract);
        console.log("Contract was calling...")
    } catch (error) {
      console.log(error);
    }
  }

  const readData = async () => {
    if(smartContract) {
      try {
          const result = await smartContract.methods.name().call();
          setReadValue(result);
      } catch (error) {
        console.log(error);
      }
    } else {
      console.log("Not uploaded smart contract!");
    }
  }

  const writeData = async () => {
    if(smartContract) {
      try {
         const value = web3.utils.toWei(amount, "ether");
         await smartContract.methods.transfer(reciever, value).send({from: account[0]});
      } catch (error) {
        console.log(error);
      }
    } else {
      console.log("Not uploaded smart contract!");
    }
  }


  useEffect(() => {
    connectSmartContract();
  }, [])

  return (
    <div className="App">
      <p>Hello Lestonz!</p>
        {
          account.length > 0 ? (
            <div>
              <p>Connected Wallet is: {account[0]}</p>
              <p>Name of the Token {readValue}</p>
              <button onClick={readData} >Read Data</button>

              <input type='text' value={amount} onChange={(e) =>setAmount(e.target.value) } placeholder='Amount of ETH' />
              <input type='text' value={reciever} onChange={(e) => setReciever(e.target.value) } placeholder='Address of Reciever' />
              <button onClick={writeData}> Send Token( Write Data) </button>
            </div>
          ) : (
            <button onClick={connectWallet} >Connect Your Wallet!</button>
          )
        }
    </div>
  );
}

export default App;
