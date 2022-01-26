//
//  RCRTCCmdManager.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RCRTCCommand;

@interface RCRTCCmdManager : NSObject

- (void)push:(RCRTCCommand *)command;

- (NSArray *)fetchOperation;

@end

NS_ASSUME_NONNULL_END
