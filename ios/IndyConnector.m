//
//  IndyConnector.m
//  RNIndy
//
//  Created by Eduard Čuba on 12.07.19.
//  Copyright © 2019 Eduard Čuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Indy/Indy.h>

#import "IndyConnector.h"

@implementation IndyConnector

NSString *credentials = @"{\"key\":\"%@\", \"key_derivation_method\": \"RAW\"}";

+ (void) openWallet:(NSString *)name key:(NSString *)key callback:(void (^)(NSError *error, IndyHandle handle))callback {
    NSString *walletConfig = [NSString stringWithFormat:@"{\"id\":\"%@\"}", name];
    NSString *credentialsConfig = [NSString stringWithFormat:credentials, key];
    [[IndyWallet sharedInstance]
      openWalletWithConfig:walletConfig
      credentials:credentialsConfig
      completion:callback
    ];
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
