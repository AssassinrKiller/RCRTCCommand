//
//  RCRTCCmdService.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCCmdService : NSObject

+ (void)commandAWithParams:(NSDictionary *)params
                completion:(void(^)(BOOL isSuccess, NSInteger code))completion;

+ (void)commandBWithParams:(NSDictionary *)params
                completion:(void(^)(BOOL isSuccess, NSInteger code))completion;

+ (void)checkCommandFinished;

@end

NS_ASSUME_NONNULL_END
