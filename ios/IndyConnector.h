//
//  IndyConnector.h
//  RNIndy
//
//  Created by Eduard Čuba on 12.07.19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#ifndef IndyConnector_h
#define IndyConnector_h

@interface IndyConnector : NSObject

+ (void) connectToLedger:(void (^)(NSError *error))callback;
+ (void) createWallet:(NSString *)name callback:(void (^)(NSError *error))callback;

@end

#endif /* IndyConnector_h */

