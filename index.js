
import { NativeModules } from 'react-native';

const { RNIndy } = NativeModules;

const createWallet = RNIndy.createWallet;

export { createWallet };
export default RNIndy;
