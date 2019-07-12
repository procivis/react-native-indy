//
//  IndyConnector.m
//  RNIndy
//
//  Created by Eduard Čuba on 12.07.19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Indy/Indy.h>

#import "IndyConnector.h"

@implementation IndyConnector

NSString *credentials = @"{\"key\":\"6nxtSiXFvBd593Y2DCed2dYvRY1PGK9WMtxCBjLzKgbw\", \"key_derivation_method\": \"RAW\"}";

+ (void) openWallet:(NSString *)name callback:(void (^)(NSError *error))callback {
    NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
    __block IndyHandle walletHandle;
    [[IndyWallet sharedInstance]
      openWalletWithConfig:walletConfig
      credentials:credentials
      completion:^(NSError *error, IndyHandle h) {
        walletHandle = h;
        if ([error code]) {
          // [self.StatusText insertText: [error localizedDescription]];
        } else {
          // [self.StatusText insertText: @"OK\n"];
        }
    }];
}

+ (void) createWallet:(NSString *)name callback:(void (^)(NSError *error))callback {

    NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
  
    [[IndyWallet sharedInstance]
      createWalletWithConfig:walletConfig
      credentials:credentials
      completion:callback
    ];
}

+ (void) connectToLedger:(void (^)(NSError *error))callback {
  [IndyPool setProtocolVersion:@(2)
    completion:^(NSError *error) {
    if ([error code]) {
      // self.StatusText.text = [error localizedDescription];
    } else {
      // self.StatusText.text = @"OK\n";
      // [self createWallet];
    }
  }];
}

@end
