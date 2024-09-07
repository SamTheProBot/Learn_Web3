import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';
import { ethers } from 'ethers';

const Lottery = buildModule('Lottery', (m) => {
  const minEth = ethers.parseEther('0.005');
  const subId = BigInt('98631603617788290657776115822039576426117444017679131352204212569160055959974');

  const contract = m.contract('Lottery', [minEth, subId], {});

  return { contract };
});

export default Lottery;
