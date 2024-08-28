const hre = require('hardhat');

async function main() {
  const CurrentTimeInSec = Math.round(Date.now() / 1000);
  const One_Month = 24 * 60 * 60;
  const unlocktime = CurrentTimeInSec + One_Month;

  const ethAmount = '100000000000000000'; // wei

  const Token = await hre.ethers.getContractFactpry;
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
