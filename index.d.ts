declare module 'react-native-indy' {
  export function createWallet(name: string, key: string): Promise<boolean>;
  export function generateWalletKey(seed: string): Promise<string>;
}
