//
//  RNIndy+Request.m
//  RNIndy
//
//  Created by Eduard Čuba on 22.07.19.
//  Copyright © 2019 Eduard Čuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Indy/Indy.h>
#import "RNIndy+Request.h"

@implementation RNIndy (Request)

RCT_EXPORT_METHOD(
  buildNymRequest:(nonnull NSString *)submitterDid
        targetDid:(nonnull NSString *)targetDid
         resolver:(RCTPromiseResolveBlock)resolve
         rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyLedger
    buildNymRequestWithSubmitterDid:submitterDid
                          targetDID:targetDid
                             verkey:nil
                              alias:nil
                               role:nil
                         completion:^(NSError *error, NSString *requestJSON) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(requestJSON);
    }
  }];
}

RCT_EXPORT_METHOD(
  buildGetNymRequest:(nonnull NSString *)did
            resolver:(RCTPromiseResolveBlock)resolve
            rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyLedger
    buildGetNymRequestWithSubmitterDid:did
                             targetDID:did
                            completion:^(NSError *error, NSString *requestJSON) {

    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(requestJSON);
    }
  }];
}

@end
