
import { NativeModules } from 'react-native';

const { RNIndy } = NativeModules;

const {
  createWallet,
  openWallet,
  generateWalletKey,
  setProtocolVersion,
  createPoolLedgerConfig,
  openPoolLedger,
  closePoolLedger,
  createAndStoreMyDid,
} = RNIndy;

export {
  createWallet,
  openWallet,
  generateWalletKey,
  setProtocolVersion,
  createPoolLedgerConfig,
  openPoolLedger,
  closePoolLedger,
  createAndStoreMyDid,
};
