
#import <Indy/Indy.h>

#import "RNIndy.h"

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

/* Ledger methods */

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
