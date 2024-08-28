interface chainConfigType {
  [name: string]: {
    chainId: number;
    priceFeed: any;
  };
}

export const chainConfig: chainConfigType = {
  localhost: {
    chainId: 31337,
    priceFeed: '',
  },
  sepolia: {
    chainId: 11155111,
    priceFeed: '0x694AA1769357215DE4FAC081bf1f309aDC325306',
  },
};
