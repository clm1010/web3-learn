import { ConnectButton } from '@rainbow-me/rainbowkit'
import styles from '../styles/Home.module.css'

const Header = () => {
  return (
    <div className={styles.header}>
      <div>Dapp前端</div>
      <div>
        <ConnectButton />
      </div>
    </div>
  )
}

export default Header
