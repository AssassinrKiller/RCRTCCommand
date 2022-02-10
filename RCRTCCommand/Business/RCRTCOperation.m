//
//  RCRTCOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCOperation.h"
#import "RCRTCCmdService.h"

@interface RCRTCOperation ()

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) NSInteger code;
@property (assign) BOOL isExecuting;
@property (assign) BOOL isFinished;

@end

@implementation RCRTCOperation

- (void)start {
    [self prepare];

    if ([self checkIsCancelled]) {
        [self finishedAction];
        return;
    }
    
    [self setIsExecuting:YES];
    [self setIsFinished:NO];
    
    if (![self checkCommandStatus]) {
        [self finishedAction];
        return;
    }
    
    [self action];
}

- (void)action {
    
}

- (void)prepare {
    
}

- (BOOL)checkIsCancelled {
    if ([self isCancelled]) {
        self.isSuccess = NO;
        self.code = -1;
        return YES;
    }
    return NO;
}

- (BOOL)checkCommandStatus {
    BOOL res = self.command.isContinue;
    if (!res) {
        self.isSuccess = NO;
        self.code = _isSuccess ? 0 : -1;
    }
    return res;
}

- (void)setIsContinue:(BOOL)isContinue {
    [self.command finishedWithOpName:self.name
                            response:self.response
                          isContinue:isContinue];
}

- (void)finishedAction {
    [self setIsFinished:YES];
    [self setIsExecuting:NO];
    NSLog(@"%@ --- 执行结束了",self);
}


@end
