'use client';

import { abi } from '@/constants/abi';
import { contractAddress } from '@/constants/address';
import { ethers } from 'ethers';

export default function Home() {
  const getEnternceFee = async () => {
    if (typeof window.ethereum != undefined) {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, abi, signer);
      try {
        const transaction = await contract.requestRandomNumber();
        console.log(transaction);
      } catch (e) {
        throw e;
      }
    } else {
      console.log(`please connect your meta mask wallet`);
    }
  };

  return (
    <>
      <div>
        <button className='bg-blue-600 text-white py-3 px-4 rounded-lg' onClick={getEnternceFee}>
          Join Lottery
        </button>
      </div>
    </>
  );
}
