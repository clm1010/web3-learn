import { useMemo } from 'react'
import { Abi, Address, WalletClient } from 'viem'
import { useChainId, useWalletClient } from 'wagmi'
import { getContract } from '@/utils/contractHelper'
import { StakeContractAddress } from '@/utils/env'
import { stakeAbi } from '@/assets/abis/stake'

type UseContractOptions = {
  chainId?: number
}

export function useContract<TAbi extends Abi>(
  addressOrAddressMap?: Address | { [chainId: number]: Address },
  abi?: TAbi,
  options?: UseContractOptions
) {
  const currentChainId = useChainId()
  const chainId = options?.chainId || currentChainId
  const { data: walletClient } = useWalletClient()

  return useMemo(() => {
    if (!addressOrAddressMap || !abi || !chainId) return null
    let address: Address | undefined
    if (typeof addressOrAddressMap === 'string') address = addressOrAddressMap
    else address = addressOrAddressMap[chainId]
    if (!address) return null
    try {
      return getContract({
        abi,
        address,
        chainId,
        signer: walletClient ?? undefined
      })
    } catch (error) {
      console.error('Failed to get contract', error)
      return null
    }
  }, [addressOrAddressMap, abi, chainId, walletClient])
}

/*************  ✨ Codeium Command ⭐  *************/
/**
 * React hook to get the Stake contract instance.
 *
 * @returns The Stake contract instance if the wallet is connected and the
 *   contract is deployed on the current chain, otherwise null.
 */
/******  c2ece194-f9e6-40c2-9e93-ff8250d06b5c  *******/ export const useStakeContract =
  () => {
    return useContract(StakeContractAddress, stakeAbi as Abi)
  }
