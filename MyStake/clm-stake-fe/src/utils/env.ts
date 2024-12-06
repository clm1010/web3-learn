import {Address, zeroAddress} from 'viem'


export const ReownProjectId = `${process.env.REOWN_PROJECt_ID}` as string

export const StakeContractAddress = `${process.env.NEXT_PUBLIC_CLM_STAKE_CONTRACT_ADDRESS}` as Address || zeroAddress