import { ethers } from 'ethers';
import { contractABI, contractAddress } from '../constants';

export default async function withdraw() {
  console.log(`withdrawing...`);
  if (typeof window.ethereum !== `undefined`) {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(contractAddress, contractABI, signer);
    try {
      const transaction = await contract.withdraw();
      const recipt = await transaction.wait();
      console.log(`funds transferd,${recipt.hash}`);
    } catch (err) {
      console.log(`something went wrong...`);
    }
  } else {
    console.log(`please connect your meta mask wallet`);
  }
}
