import { ethers } from 'ethers';
import { contractABI, contractAddress } from '../constants';

export default async function fund(value) {
  console.log(`funding... ${value}`);
  if (typeof window.ethereum !== 'undefined') {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(contractAddress, contractABI, signer);

    try {
      const transaction = await contract
        .fund({
          value: ethers.parseEther(value.toString()),
        })
        .catch((err) => console.log(err));
      const reciept = await transaction.wait();
      console.log(`woking ${reciept}`);
    } catch (err) {
      console.log(`something went wrong...`);
    }
  } else {
    console.log(`please connect your mata mask wallet`);
  }
}
