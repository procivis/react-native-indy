
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
  generateWalletKey:(NSString *)seed
           resolver:(RCTPromiseResolveBlock)resolve
           rejecter:(RCTPromiseRejectBlock)reject
) {
  if (!seed) {
    // reject the promise with error
    NSError *error = [self createError: @"No seed value provided"];
    reject(@"RNIndy", [error localizedDescription], error);
  } else if ([seed length] != 64) {
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
  createWallet:(NSString *)name
           key:(NSString *)key
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
  createPoolLedgerConfig:(NSString *)name
                resolver:(RCTPromiseResolveBlock)resolve
                rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyPool createPoolLedgerConfigWithPoolName:name poolConfig:nil completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

RCT_EXPORT_METHOD(
  openPoolLedger:(NSString *)name
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
  closePoolLedger:(nonnull NSNumber *)handle
         resolver:(RCTPromiseResolveBlock)resolve
         rejecter:(RCTPromiseRejectBlock)reject
) {
  [IndyPool closePoolLedgerWithHandle:[handle intValue] completion:^(NSError *error) {
    if (error && [error code]) {
      reject(@"RNIndy", [error description], error);
    } else {
      resolve(@(true));
    }
  }];
}

@end
