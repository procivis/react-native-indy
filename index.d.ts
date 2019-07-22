
declare module 'react-native-indy' {

  interface RNIndyWallet {
    createWallet: (name: string, key: string) => Promise<boolean>;
    openWallet: (name: string, walletKey: string) => Promise<number>;
    closeWallet: (walletHandle: number) => Promise<boolean>;
    generateWalletKey: (seed: string) => Promise<string>;
    createAndStoreMyDid: (walletHandle: number, seed: string) => Promise<{did: string, verkey: string}>;
  }

  interface RNIndyRequest {
    buildNymRequest: (submitterDid: string, targetDid: string) => Promise<string>;
    buildGetNymRequest: (did: string) => Promise<string>;
  }

  interface RNIndyPool {
    openPoolLedger: (name: string) => Promise<number>;
    createPoolLedgerConfig(name: string, genesisTxtData: string): Promise<boolean>;
    closePoolLedger: (poolHandle: number) => Promise<boolean>;
  }

  interface RNIndy extends RNIndyWallet, RNIndyPool, RNIndyRequest {
    setProtocolVersion: (version: number) => Promise<boolean>;
  }

  const Indy: RNIndy;
  export default Indy;
}
