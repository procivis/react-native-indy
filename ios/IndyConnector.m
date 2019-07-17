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

NSString *credentials = @"{\"key\":\"%@\", \"key_derivation_method\": \"RAW\"}";

+ (void) openWallet:(NSString *)name key:(NSString *)key callback:(void (^)(NSError *error))callback {
    NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
    NSString *credentialsConfig = [NSString stringWithFormat:credentials, key];
  
    __block IndyHandle walletHandle;
    [[IndyWallet sharedInstance]
      openWalletWithConfig:walletConfig
      credentials:credentialsConfig
      completion:^(NSError *error, IndyHandle h) {
        walletHandle = h;
        if ([error code]) {
          // [self.StatusText insertText: [error localizedDescription]];
        } else {
          // [self.StatusText insertText: @"OK\n"];
        }
    }];
}

+ (void) createWallet:(NSString *)name
                  key:(NSString *)key
             callback:(void (^)(NSError *error))callback
{
    NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
    NSString *credentialsConfig = [NSString stringWithFormat:credentials, key];
    [[IndyWallet sharedInstance]
      createWalletWithConfig:walletConfig
      credentials:credentialsConfig
      completion:callback
    ];
}

+ (void) generateCredentials:(NSString *)seed
         callback:(void (^)(NSError *error, NSString *key))callback
{
  NSString *seedJson = [NSString stringWithFormat:@"{\"seed\":\"%@\"}", seed];
  [IndyWallet generateWalletKeyForConfig:seedJson completion:callback];
}

@end
