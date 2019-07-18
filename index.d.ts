declare module 'react-native-indy' {
  export function createWallet(name: string, key: string): Promise<boolean>;
  export function setProtocolVersion(version: number): Promise<boolean>;
  export function createPoolLedgerConfig(name: string, config: string): Promise<boolean>;
  export function closePoolLedger(handle: number): Promise<boolean>;

  export function openPoolLedger(name: string): Promise<number>;
  export function generateWalletKey(seed: string): Promise<string>;
}
