
#import "RNIndy.h"
#import "IndyConnector.h"

@implementation RNIndy

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()


RCT_EXPORT_METHOD(
  createWallet:(NSString *)name
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject)
{
  [IndyConnector
    createWallet:name
    callback:^(NSError *error){
    if (error && [error code]) {
      reject(@"RNIndy", [error localizedDescription], error);
    } else {
      resolve(@(true));
    }
  }];
}

@end
