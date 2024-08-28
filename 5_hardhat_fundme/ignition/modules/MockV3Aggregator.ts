import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

const decimals = 8;
const initial_answer = 2000000000;
const Mock = buildModule('MockV3Aggregator', (m) => {
  const MockV3Aggregator = m.contract(
    'MockV3Aggregator',
    [decimals, initial_answer],
    {}
  );

  return { MockV3Aggregator };
});
export default Mock;
