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
console.log(process.env.WalletConnectId)
export const config = getDefaultConfig({
  appName: 'RainbowKit App',
  projectId: `${process.env.REOWN_PROJECt_ID}`,
  chains: [
    mainnet,
    sepolia,
    polygon,
    optimism,
    arbitrum,
    base
    // ...(process.env.NEXT_PUBLIC_ENABLE_TESTNETS === 'true' ? [sepolia] : [])
  ],
  ssr: true
})
