//
//  RNIndy+Pool.m
//  RNIndy
//
//  Created by Eduard Čuba on 22.07.19.
//  Copyright © 2019 Eduard Čuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Indy/Indy.h>
#import "RNIndy+Pool.h"

@implementation RNIndy (Pool)

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
