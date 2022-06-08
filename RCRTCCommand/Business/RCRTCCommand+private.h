//
//  RCRTCCommand+private.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/10.
//

#import "RCRTCCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCCommand (private)

- (instancetype)initWithParams:(NSDictionary *)params;

- (void)finishedWithOpName:(NSString *)opName
                  response:(__nullable id)response
                isContinue:(BOOL)isContinue;

- (void)completion;

@end

NS_ASSUME_NONNULL_END
