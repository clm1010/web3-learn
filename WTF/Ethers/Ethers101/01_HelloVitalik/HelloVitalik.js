import 'dotenv/config';
import { ethers } from "ethers";
// const provider = ethers.getDefaultProvider();
const ALCHEMY_MAINNET_URL = `https://eth-mainnet.g.alchemy.com/v2/${process.env.ALCHEMY_KEY}`;
const provider = new ethers.providers.JsonRpcProvider(ALCHEMY_MAINNET_URL);
const main = async () => {
  const balance = await provider.getBalance(`vitalik.eth`);
  console.log(`ETH Balance of vitalik: ${ethers.utils.formatEther(balance)} ETH`);
}
main()