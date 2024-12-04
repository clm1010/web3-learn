import { formatUnits, parseUnits } from 'viem'
import { useAccount, useBalance } from 'wagmi'
import { RccTokenContract } from '@/utils'

const Info = () => {
  const { address } = useAccount()
  const { data, error } = useBalance({ address })
  const { data: rccTokenData } = useBalance({
    address,
    token: RccTokenContract
  })
  console.log(data, 'balance')

  // parseUnits()

  return (
    <div>
      <div>Address: {address}</div>
      {data && <div>ETH Balance: {formatUnits(data?.value, 18)}</div>}
      {rccTokenData && (
        <div>Rcc Balance: {formatUnits(rccTokenData?.value, 18)}</div>
      )}
    </div>
  )
}

export default Info
