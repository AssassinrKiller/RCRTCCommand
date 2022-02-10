//
//  RCRTCCmdService.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCCmdService : NSObject

+ (void)commandWithCmdName:(NSString *)cmdName
                    params:(NSDictionary *)params
                completion:(id)completion;

+ (void)cancelCurrentCmd;

+ (void)checkCommandFinished;

@end

NS_ASSUME_NONNULL_END
