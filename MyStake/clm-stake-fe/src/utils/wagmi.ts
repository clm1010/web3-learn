import { ReownProjectId } from '@/utils/env';
import { getDefaultConfig } from '@rainbow-me/rainbowkit';
import {
  arbitrum,
  base,
  mainnet,
  optimism,
  polygon,
  sepolia,
} from 'wagmi/chains';
console.log(ReownProjectId);
export const config = getDefaultConfig({
  appName: 'CLMStake APP',
  projectId: ReownProjectId,
  chains: [
    sepolia,
    mainnet,
    polygon,
    optimism,
    // arbitrum,
    // base,
    // ...(process.env.NEXT_PUBLIC_ENABLE_TESTNETS === 'true' ? [sepolia] : []),
  ],
  ssr: true,
});

export const defaultChainId: number = sepolia.id