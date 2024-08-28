import {
  ethers,
  BaseContract,
  ContractTransaction,
  ContractDeployTransaction,
} from 'ethers';
import fs from 'fs';
import dotenv from 'dotenv';
dotenv.config();

interface TOKEN_CONTRACT extends BaseContract {
  getYourFavNumber(): Promise<number>;
  getYourFavSentence(): Promise<string>;
  setYourFavNumber(newNum: number): Promise<ContractDeployTransaction>;
  setYourFavSentence(newSentence: string): Promise<ContractDeployTransaction>;
}

const mainFunction = async () => {
  const abi = fs.readFileSync('./contract_contract_sol_Token.abi', 'utf8');
  const binary = fs.readFileSync('./contract_contract_sol_Token.bin', 'utf8');

  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);

  const contract = (await contractFactory.deploy({
    gasPrice: ethers.parseUnits('200', 'gwei'),
  })) as TOKEN_CONTRACT;
  console.log(`deploying contract at address ${contract.target}`);
  await contract.deploymentTransaction().wait(1);

  console.log(`current FavNumber: ${await contract.getYourFavNumber()}`);
  console.log(`current fav sentrence: ${await contract.getYourFavSentence()}`);

  await contract.setYourFavNumber(69);

  console.log(`current FavNumber: ${await contract.getYourFavNumber()}`);
};
mainFunction();
