import { mainnet } from 'viem/chains'
import { sepolia } from 'viem/chains'
import { PublicClient, createPublicClient, http } from 'viem'

const viewClients = (chaiId: number): PublicClient => {
  const clients: {
    [key: number]: PublicClient
  } = {
    [sepolia.id]: createPublicClient({
      chain: sepolia,
      transport: http()
    })
  }
  return clients[chaiId]
}

export default viewClients
