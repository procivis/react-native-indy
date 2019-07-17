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

+ (void) createWallet:(NSString *)name key:(NSString *)key callback:(void (^)(NSError *error))callback;
+ (void) generateCredentials:(NSString *)seed callback:(void (^)(NSError *error, NSString *key))callback;
@end

#endif /* IndyConnector_h */

