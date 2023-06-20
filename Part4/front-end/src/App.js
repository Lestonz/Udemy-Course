import React, {useEffect, useState} from 'react';
import Web3 from 'web3';

import './App.css';
import ABI from '../src/assets/abi.json'
const gif = require("../src/assets/gifForMint.gif");

function App() {
  const [account, setAccount] = useState([]);
  const [smartContract, setSmartContract] = useState(null);
  const [readValue, setReadValue] = useState({
    name: "",
    symbol: "",
    totalSupply:"",
    maxSupply: "",
    maxMintPerTx:"",
    cost: ""
  });
  const [mintAmount, setMintAmount] = useState(1);
  const [mintPrice, setMintPrice] = useState(0);

  const web3 = new Web3 ( Web3.givenProvider || "https://sepolia.infura.io/v3/0d381a998b1e418f98ef69b7b3d29ed5");

  const mintAmountDecr = () => {
    setMintAmount(e => Math.max(1, e-1));
  }

  const mintAmountIncr = () => {
    setMintAmount(e => e + 1);
  }


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
        const contractABI = ABI.abi;
        const contractAddress = "0x262bBE7E25D06eFDe06912a985b2b213f59585c0";

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
          const name = await smartContract.methods.name().call();
          const symbol = await smartContract.methods.symbol().call();
          const totalSupply = await smartContract.methods.totalSupply().call();
          const maxSupply = await smartContract.methods.maxSupply().call();
          const maxMintPerTx = await smartContract.methods.maxMintPerTx().call();
          const cost = await smartContract.methods.cost().call();

          setMintPrice(cost);
          const price = web3.utils.fromWei(cost, "ether");
          setReadValue({
            name:name,
            symbol:symbol,
            totalSupply:totalSupply,
            maxSupply:maxSupply,
            maxMintPerTx:maxMintPerTx,
            cost:price
          })
      } catch (error) {
        console.log(error);
      }
    } else {
      console.log("Not uploaded smart contract!");
    }
  }

  const mint = async () => {
    if(smartContract) {
      try {
         const value = mintAmount * mintPrice;
         await smartContract.methods.mint(mintAmount).send({from: account[0], value:value});
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

  useEffect(() => {
    readData();
  },[smartContract])

  return (
    <div className="app">
        <div className="app-img-container" >
          <img 
            src={gif} className="img-box"
          />
        </div>
        <div className="main-container" >
          <div>
            <p className="text-title" > Lestonz Home NFTs Minting Page</p>
            <p className="text-body" >Lorem Ipsum is simply dummy text of the printing and typesetting industry. </p>
          </div>
          <div>
            <p className="text-body"> {readValue.totalSupply} / {readValue.maxSupply} </p>
          </div>
          <div className="name-box" >
            <p className="text-body"> {readValue.name} - {readValue.symbol} </p>
          </div>
          {
            account.length > 0 ? (
              <div className="second-container" >
                <p className="text-body">{readValue.cost} ETH</p>
                <div className="mint-container" >
                  <button className="mint-button" onClick={mint}>MINT</button>
                  <div className="mint-control">
                    <button className="mint-decr" onClick={mintAmountDecr} >-</button>
                      <p className="mint-text" >{mintAmount}</p>
                    <button className="mint-incr"  onClick={mintAmountIncr}>+</button>
                  </div>
                </div>
            </div>
            ) : (
              <button onClick={connectWallet} className="connect-button" >
                Connect Your Wallet
              </button>
            )
          }
            


        </div>
    </div>
  );
}

export default App;
