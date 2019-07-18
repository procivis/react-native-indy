
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
  buildNymRequest,
  buildGetNymRequest,
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
  buildNymRequest,
  buildGetNymRequest,
};
