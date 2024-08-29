import { ethers } from 'ethers';
import { contractAddress } from '../constants';

export default async function cheakBalance() {
  console.log(`cheakingBalance...`);
  if (typeof window.ethereum != undefined) {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      await provider
        .getBalance(contractAddress)
        .then((response) => ethers.formatEther(response))
        .then((response) => console.log(response));
    } catch (error) {
      console.log(`something went wrong...`);
    }
  } else {
    console.log(`please connect your meta mask wallet`);
  }
}
