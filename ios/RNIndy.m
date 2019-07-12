
#import "RNIndy.h"
#import "IndyConnector.h"

@implementation RNIndy

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()


RCT_EXPORT_METHOD(createWallet:(NSString *)name)
{
  connectToLedger();
}

@end
