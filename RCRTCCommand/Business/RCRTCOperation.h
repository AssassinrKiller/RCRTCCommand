//
//  RCRTCOperation.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "RCRTCCommand+private.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCOperation : NSOperation

- (void)prepare;
- (void)action;
- (void)finishedAction;
- (BOOL)checkIsCancelled;
- (BOOL)checkCommandStatus;

@property (nonatomic, strong) RCRTCCommand *command;
@property (nonatomic, assign) BOOL isContinue;
@property (nonatomic, strong) id response;
@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) NSInteger code;

@end

NS_ASSUME_NONNULL_END
