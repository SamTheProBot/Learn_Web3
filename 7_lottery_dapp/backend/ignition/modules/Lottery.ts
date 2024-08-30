import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

const Lottery = buildModule('Lottery', (m) => {
  const contract = m.contract('Lottery', [], {});

  return { contract };
});

export default Lottery;
