
import { NativeModules } from 'react-native';

const { RNIndy } = NativeModules;

const createWallet = RNIndy.createWallet;
const generateWalletKey = RNIndy.generateWalletKey;

export { createWallet, generateWalletKey };
export default RNIndy;
