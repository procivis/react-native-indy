
import { NativeModules } from 'react-native';

const { RNIndy } = NativeModules;

const {
  createWallet,
  generateWalletKey,
  setProtocolVersion,
  createPoolLedgerConfig,
  openPoolLedger,
  closePoolLedger,
} = RNIndy;

export {
  createWallet,
  generateWalletKey,
  setProtocolVersion,
  createPoolLedgerConfig,
  openPoolLedger,
  closePoolLedger,
};
