import { Contract, Signer, Provider, JsonRpcProvider } from 'ethers'
import { RccStakeContract } from '@/utils'
import { stakeAbi } from '@/abis/stakeAbi'
import { useEthersProvider } from '@/hooks/useEthersProvider'
import { sepolia } from 'viem/chains'

const useStakeContract = (signer?: Signer) => {
  const provider = useEthersProvider({ chainId: sepolia.id })
  console.log('--------输出provider:', provider)
  return new Contract(RccStakeContract, stakeAbi, signer || provider)
}

export { useStakeContract }
