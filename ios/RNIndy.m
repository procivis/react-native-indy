
#import <Indy/Indy.h>

#import "RNIndy.h"
#import "IndyConnector.h"

@implementation RNIndy

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

- (NSError *)createError:(NSString *)message
{
  NSMutableDictionary* details = [NSMutableDictionary dictionary];
  [details setValue:message forKey:NSLocalizedDescriptionKey];
  return [NSError errorWithDomain:NSPOSIXErrorDomain code:5 userInfo:details];
}

/* Generic Exposed Methods */

RCT_EXPORT_METHOD(
  generateWalletKey:(nonnull NSString *)seed
           resolver:(RCTPromiseResolveBlock)resolve
           rejecter:(RCTPromiseRejectBlock)reject
) {
  if ([seed length] != 64) {
    NSError *error = [self createError: @"Seed has to be 32-bytes long (64 hex chars)"];
    reject(@"RNIndy", [error localizedDescription], error);
  } else {
    [IndyConnector generateCredentials:seed callback:^(NSError *error, NSString *key) {
      if (error && [error code]) {
        reject(@"RNIndy", [error debugDescription], error);
        NSLog(@"Generate wallet key error: %@", error);
      } else {
        resolve(key);
      }
    }];
  }
}

RCT_EXPORT_METHOD(
  createWallet:(nonnull NSString *)name
           key:(nonnull NSString *)key
      resolver:(RCTPromiseResolveBlock)resolve
      rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyConnector
    createWallet:name
             key:key
    callback:^(NSError *error){
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

RCT_EXPORT_METHOD(
  setProtocolVersion:(nonnull NSNumber *) version
            resolver:(RCTPromiseResolveBlock)resolve
            rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyPool setProtocolVersion:version completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

RCT_EXPORT_METHOD(
  createPoolLedgerConfig:(nonnull NSString *)name
             genesisData:(nonnull NSString *)genesisData
                resolver:(RCTPromiseResolveBlock)resolve
                rejecter:(RCTPromiseRejectBlock)reject
) {

  NSString *filePath = [NSString stringWithFormat:@"%@%@.txn", [NSMutableString stringWithString:NSTemporaryDirectory()], name];
  
  BOOL success = [[NSFileManager defaultManager]
    createFileAtPath:filePath
            contents:[NSData dataWithBytes:[genesisData UTF8String] length:[genesisData length]]
          attributes:nil];
  
  if (!success){
      NSError *error = [self createError: @"Failed to write the genesis file"];
      reject(@"RNIndy", [error localizedDescription], error);
      return;
  }
  
  NSString *poolConfig = [NSString stringWithFormat:@"{\"genesis_txn\":\"%@\"}", filePath];

  [IndyPool createPoolLedgerConfigWithPoolName:name poolConfig:poolConfig completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

/* Wallet handle methods */

RCT_EXPORT_METHOD(
    openWallet:(nonnull NSString *)name
     walletKey:(nonnull NSString *)walletKey
      resolver:(RCTPromiseResolveBlock)resolve
      rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyConnector
    openWallet:name
           key:walletKey
      callback:^(NSError *error, IndyHandle handle) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve([NSNumber numberWithInt:handle]);
    }
  }];
}

RCT_EXPORT_METHOD(
  createAndStoreMyDid:(nonnull NSNumber *)walletHandle
                 seed:(nonnull NSString *)seed
             resolver:(RCTPromiseResolveBlock)resolve
             rejecter:(RCTPromiseRejectBlock)reject
) {
  NSString *didConfig = [NSString stringWithFormat:@"{\"seed\":\"%@\"}", seed];

  [IndyDid createAndStoreMyDid:didConfig
                  walletHandle:[walletHandle intValue]
                    completion:^(NSError *error, NSString *did, NSString *verkey) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      NSDictionary *response = [NSDictionary dictionaryWithObjectsAndKeys:
        did, @"did",
        verkey, @"verkey", 
        nil
      ];
      resolve(response);
    }
  }];
}


/* Pool handle methods */

RCT_EXPORT_METHOD(
  openPoolLedger:(nonnull NSString *)name
        resolver:(RCTPromiseResolveBlock)resolve
        rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyPool openPoolLedgerWithName:name poolConfig:nil completion:^(NSError *error, IndyHandle poolHandle) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve([NSNumber numberWithInt:poolHandle]);
    }
  }];
}

RCT_EXPORT_METHOD(
  closePoolLedger:(nonnull NSNumber *)poolHandle
         resolver:(RCTPromiseResolveBlock)resolve
         rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyPool closePoolLedgerWithHandle:[poolHandle intValue] completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

@end
