//
//  RNIndyWallet.m
//  RNIndy
//
//  Created by Eduard Čuba on 22.07.19.
//  Copyright © 2019 Eduard Čuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Indy/Indy.h>
#import "RNIndy+Wallet.h"

@implementation RNIndy (Wallet)

NSString *credentials = @"{\"key\":\"%@\", \"key_derivation_method\": \"RAW\"}";

RCT_EXPORT_METHOD(
  generateWalletKey:(nonnull NSString *)seed
           resolver:(RCTPromiseResolveBlock)resolve
           rejecter:(RCTPromiseRejectBlock)reject
) {
  if ([seed length] != 64) {
    NSError *error = [self createError: @"Seed has to be 32-bytes long (64 hex chars)"];
    reject(@"RNIndy", [error localizedDescription], error);
  } else {
    NSString *seedJson = [NSString stringWithFormat:@"{\"seed\":\"%@\"}", seed];
    [IndyWallet generateWalletKeyForConfig:seedJson completion:^(NSError *error, NSString *key) {
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
  NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
  NSString *credentialsConfig = [NSString stringWithFormat:credentials, key];
  [[IndyWallet sharedInstance]
    createWalletWithConfig:walletConfig
               credentials:credentialsConfig
                completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

RCT_EXPORT_METHOD(
    openWallet:(nonnull NSString *)name
     walletKey:(nonnull NSString *)walletKey
      resolver:(RCTPromiseResolveBlock)resolve
      rejecter:(RCTPromiseRejectBlock)reject
) {
  NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
  NSString *credentialsConfig = [NSString stringWithFormat:credentials, walletKey];
  [[IndyWallet sharedInstance]
    openWalletWithConfig:walletConfig
             credentials:credentialsConfig
              completion:^(NSError *error, IndyHandle handle) {
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

RCT_EXPORT_METHOD(
  closeWallet:(nonnull NSNumber *)walletHandle
     resolver:(RCTPromiseResolveBlock)resolve
     rejecter:(RCTPromiseRejectBlock)reject
) {
  [[IndyWallet sharedInstance]
    closeWalletWithHandle:[walletHandle intValue]
               completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

@end
