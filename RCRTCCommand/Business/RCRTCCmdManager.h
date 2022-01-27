//
//  RCRTCCmdManager.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RCRTCCommand, RCRTCOperation;

@interface RCRTCCmdManager : NSObject

- (void)push:(RCRTCCommand *)command;

- (NSArray<RCRTCOperation *> *)fetchOperations;

@property (nonatomic, readonly)RCRTCCommand *currentCmd;

@end

NS_ASSUME_NONNULL_END
