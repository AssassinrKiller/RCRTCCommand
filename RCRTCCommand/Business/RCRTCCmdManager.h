//
//  RCRTCCmdManager.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "RCRTCDataSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

@class RCRTCCommand, RCRTCOperation;

@interface RCRTCCmdManager : NSObject

- (void)push:(RCRTCCommand *)command;

- (NSArray<RCRTCOperation *> *)fetchOperations;

@property (nonatomic, readonly, weak)RCRTCCommand *currentCmd;

@property (nonatomic, weak) id<RCRTCCmdServiceDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
