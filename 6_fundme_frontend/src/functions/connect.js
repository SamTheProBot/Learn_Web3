export default async function connect() {
  if (typeof window.ethereum !== 'undefined') {
    try {
      await window.ethereum
        .request({
          method: 'eth_requestAccounts',
        })
        .then((response) => console.log(response))
        .catch((err) => {
          if (err.code == 4001) {
            ethereumButton.innerHTML = 'please Connect your MetaMask';
          } else {
            ethereumButton.innerHTML = 'try again';
          }
        });
    } catch (err) {
      console.log(`something went wrong...`);
    }
  } else {
    ethereumButton.innerHTML = 'install meta mask!';
  }
}
