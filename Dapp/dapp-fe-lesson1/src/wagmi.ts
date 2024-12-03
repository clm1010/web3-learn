import 'dotenv/config'
import { getDefaultConfig } from '@rainbow-me/rainbowkit'
import {
  arbitrum,
  base,
  mainnet,
  optimism,
  polygon,
  sepolia
} from 'wagmi/chains'

export const config = getDefaultConfig({
  appName: 'RainbowKit App',
  projectId: `${process.env.REOWN_PROJECt_ID}`,
  chains: [
    mainnet,
    polygon,
    optimism,
    arbitrum,
    base,
    sepolia
    // ...(process.env.NEXT_PUBLIC_ENABLE_TESTNETS === 'true' ? [sepolia] : []),
  ],
  ssr: true
})
