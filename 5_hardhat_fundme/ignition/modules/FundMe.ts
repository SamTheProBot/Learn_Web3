import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';
import { network } from 'hardhat';
import dotenv from 'dotenv';
import Mock from './MockV3Aggregator';
import { chainToDeploy } from '../../hardhat.config';
import { chainConfig } from '../../deploy.helper';
dotenv.config();

const PUBLIC_KEY = process.env.PUBLIC_KEY;

export default buildModule('FundMe', (m) => {
  const PriceConverter = m.library('PriceConverter');
  const useChain = chainConfig[chainToDeploy];
  let priceFeed = useChain.priceFeed;
  let owner: any = PUBLIC_KEY;
  let user: any = PUBLIC_KEY;

  if (network.name == 'localhost') {
    const { MockV3Aggregator } = m.useModule(Mock);
    priceFeed = MockV3Aggregator.type;
    owner = m.getAccount(1);
    user = m.getAccount(3);
  }

  const contract = m.contract('FundMe', [priceFeed], {
    libraries: {
      PriceConverter,
    },
  });

  const ethValue = 2 * 1e15;

  m.call(contract, 'fund', [], {
    value: BigInt(ethValue),
    from: user,
  });

  m.call(contract, 'withdraw', [], {
    from: owner,
  });

  m.call(contract, 'EthValue', [], {
    value: BigInt(0),
  });

  return { contract };
});
