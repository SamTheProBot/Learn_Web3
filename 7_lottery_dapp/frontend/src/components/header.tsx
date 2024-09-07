'use client';

import { useState, useEffect } from 'react';
import { ethers } from 'ethers';

const Header = () => {
  const [isUserConnected, setIsUserConnected] = useState<Boolean>(false);
  const [connectedAccount, setConnectedAccount] = useState<string>('');
  const [accountBalance, setAccountBalance] = useState<number>(0);

  const checkConnection = async () => {
    if (typeof window.ethereum !== 'undefined') {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_accounts' });
        const account = await window.ethereum.request({
          method: 'eth_getBalance',
          params: [accounts[0].toString(16), 'latest'],
        });
        setAccountBalance(Math.round(parseFloat(ethers.formatEther(account)) * 1000000) / 1000000);
        setIsUserConnected(accounts.length > 0);
        setConnectedAccount(accounts[0]);
      } catch (err) {
        console.error('Error checking connection:', err);
      }
    }
  };

  useEffect(() => {
    checkConnection();
    const handleAccountChange = (accounts: string[]) => {
      if (accounts.length === 0) {
        setIsUserConnected(false);
      } else {
        setConnectedAccount(accounts[0]);
      }
    };
    const handleDisconnect = () => {
      setIsUserConnected(false);
    };

    if (typeof window.ethereum !== 'undefined') {
      window.ethereum.on('accountsChanged', handleAccountChange);
      window.ethereum.on('disconnect', handleDisconnect);
    }
    return () => {
      if (typeof window.ethereum !== 'undefined' && window.ethereum.removeListener) {
        window.ethereum.removeListener('accountsChanged', handleAccountChange);
        window.ethereum.removeListener('disconnect', handleDisconnect);
      }
    };
  }, []);

  const connectToWallet = async () => {
    if (typeof window.ethereum !== 'undefined') {
      try {
        const accounts = await window.ethereum.request({
          method: 'eth_requestAccounts',
        });
        if (accounts.length > 0) {
          setIsUserConnected(true);
          setConnectedAccount(accounts[0]);
        }
      } catch (err: any) {
        if (err.code === 4001) {
          console.log('User rejected the request');
        } else {
          console.log('Error connecting to wallet:', err);
        }
      }
    } else {
      console.log('MetaMask is not installed');
    }
  };

  return (
    <nav className='p-6 flex flex-row'>
      <h1 className='py-2 font-bold text-4xl flex items-center'>Decentralized Lottery!</h1>
      <div className='ml-auto py-2 px-4 flex justify-center items-center'>
        {isUserConnected ? (
          <div className='bg-blue-500 border-4 border-blue-600 p-2 font-semibold tracking-wide rounded-[20px]'>
            <span className='p-2'>{accountBalance}</span>
            <span className='p-2 bg-blue-400 text-blue-800 rounded-xl'>{`${connectedAccount.substring(
              0,
              6
            )}...${connectedAccount.substring(connectedAccount.length - 6)}`}</span>
          </div>
        ) : (
          <div>
            <button onClick={connectToWallet} className='bg-blue-600 text-white p-3 rounded-lg'>
              Connect Wallet
            </button>
          </div>
        )}
      </div>
    </nav>
  );
};

export default Header;
