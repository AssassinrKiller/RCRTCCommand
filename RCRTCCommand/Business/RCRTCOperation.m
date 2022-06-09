//
//  RCRTCOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCOperation.h"
#import "RCRTCCmdService.h"

@interface RCRTCOperation ()

@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;

@end

@implementation RCRTCOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)dealloc {
    NSLog(@"%@ operation dealloc", self);
}

- (void)start {
    @autoreleasepool {
        NSLog(@"%@ operation start", self);
        [self prepare];

        if ([self checkIsCancelled]) {
            [self finishedAction];
            return;
        }
        
        self.executing = YES;
        self.finished = NO;
        
        if (![self checkCommandStatus]) {
            [self finishedAction];
            return;
        }
        
        if (![self checkParamsIntegrality]) {
            [self finishedAction];
            return;
        }
    
        [self action];
    };
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
    if (!self.command.isContinue) {
        self.isSuccess = NO;
        self.code = -2;
        return YES;
    }
    return NO;
}

- (BOOL)checkCommandStatus {
    BOOL res = self.command.status == RCRTCCommandStatus_Normal;
    if (!res) {
        self.isSuccess = NO;
        self.code = -3;
    }
    return res;
}

- (BOOL)checkParamsIntegrality {
    return YES;
}

- (void)finishedAction {
    [self messageToCommand];
    self.executing = NO;
    NSLog(@"%@ operation finished", self);
    self.finished = YES;
}

- (void)setIsSuccess:(BOOL)isSuccess {
    _isSuccess = isSuccess;
}

- (void)messageToCommand {
    [self.command finishedWithOpName:self.name
                            isSucess:self.isSuccess
                             errCode:self.code
                            response:self.response];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return YES;
}

- (BOOL)isAsynchronous {
    return YES;
}


@end
