
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

@interface RNIndy : NSObject <RCTBridgeModule>
- (NSError *)createError:(NSString *)message;
@end
