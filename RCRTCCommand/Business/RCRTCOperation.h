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
- (BOOL)checkIsCancelled;
- (BOOL)checkCommandStatus;
- (BOOL)checkParamsIntegrality;
- (void)action;
- (void)finishedAction;

@property (nonatomic, strong) RCRTCCommand *command;
@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id response;

@end

NS_ASSUME_NONNULL_END
