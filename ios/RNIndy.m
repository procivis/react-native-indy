
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

@end
