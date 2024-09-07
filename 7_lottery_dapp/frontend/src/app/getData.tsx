import { abi } from '@/constants/abi';
import { contractAddress } from '@/constants/address';
import { ethers } from 'ethers';

const provider = new ethers.BrowserProvider(window.ethereum);
