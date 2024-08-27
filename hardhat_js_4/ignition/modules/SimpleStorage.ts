import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

export default buildModule('SimpleStorage', (m) => {
  const ss = m.contract('SimpleStorage');
  console.log(ss);
  return { ss };
});
