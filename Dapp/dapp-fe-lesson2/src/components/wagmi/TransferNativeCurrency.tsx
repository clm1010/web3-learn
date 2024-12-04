import { Box, Button } from '@mui/material'
import { parseEther } from 'viem'
import { useSendTransaction, useWaitForTransactionReceipt } from 'wagmi'
import { TO_ADDRESS } from '@/utils'

const Transfer = () => {
  const { sendTransaction, data } = useSendTransaction()
  const { status, data: txData } = useWaitForTransactionReceipt({
    hash: data
  })

  const handleTransfer = () => {
    const res = sendTransaction({
      to: TO_ADDRESS,
      value: parseEther('0.001')
    })
    console.log('res', res)
  }
  console.log(status, 'status', data, 'data', txData, 'txData')
  return (
    <Box p='20px' sx={{ border: '1px solid #888', width: '100%' }}>
      <Button onClick={handleTransfer} variant='contained'>
        Transfer 0.001 ETH
      </Button>
    </Box>
  )
}

export default Transfer
