//
//  RCRTCOperation.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "RCRTCCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCOperation : NSOperation

- (void)prepare;
- (void)action;
- (void)finishedAction;
- (BOOL)checkIsCancelled;
- (BOOL)checkCommandStatus;

@property (readonly) BOOL isExecuting;
@property (readonly) BOOL isFinished;

@property (nonatomic, strong) RCRTCCommand *command;

@end

NS_ASSUME_NONNULL_END
