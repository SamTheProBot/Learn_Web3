import fund from './functions/fund';
import connect from './functions/connect';
import withdraw from './functions/withdraw';
import cheakBalance from './functions/balance';

const ethereumButton = document.querySelector('#connect');
const balanceButton = document.querySelector('#balance');
const fundButton = document.querySelector('#fund');
const withdrawButton = document.querySelector('#withdraw');
const inputValue = document.querySelector('#ethAmount');

ethereumButton.addEventListener('click', () => {
  connect();
});

balanceButton.addEventListener('click', () => {
  cheakBalance();
});

fundButton.addEventListener('click', () => {
  fund(inputValue.value);
});

withdrawButton.addEventListener('click', () => {
  withdraw();
});
