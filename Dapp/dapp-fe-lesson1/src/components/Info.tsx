import 'dotenv/config'
import { formatUnits, parseUnits } from 'viem'
import { useAccount, useBalance } from 'wagmi'

const Info = () => {
  const { address } = useAccount()
  const { data, error } = useBalance({ address })
  const { data: rccTokenData } = useBalance({
    address,
    token: `0x${process.env.MY_TOKEN}`
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
