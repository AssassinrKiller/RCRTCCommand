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
    NSLog(@"%@ op 正常释放...",self);
}

- (void)start {
    if (self.command.executeType == RCRTCCommandExecuteType_sync) {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    }
    
    @autoreleasepool {
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
    return NO;
}

- (BOOL)checkCommandStatus {
    _isContinue = self.command.isContinue;
    if (!_isContinue) {
        _isSuccess = NO;
        _code = _isSuccess ? 0 : -1;
    }
    return _isContinue;
}

- (void)finishedAction {
    self.executing = NO;
    self.finished = YES;
    NSLog(@"%@ --- 执行结束了",self);
    [self messageToCommand];
}

- (void)setIsSuccess:(BOOL)isSuccess {
    _isSuccess = isSuccess;
    _isContinue = _isSuccess;
}

- (void)messageToCommand {
    [self.command finishedWithOpName:self.name
                            response:self.response
                          isContinue:self.isContinue];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return YES;
}

//- (void)setExecuting:(BOOL)executing {
//    [self willChangeValueForKey:@"isExecuting"];
//    _executing = executing;
//    [self didChangeValueForKey:@"isExecuting"];
//}
//
//- (BOOL)isExecuting {
//    return _executing;
//}
//
//- (void)setFinished:(BOOL)finished {
//    [self willChangeValueForKey:@"isFinished"];
//    _finished = finished;
//    [self didChangeValueForKey:@"isFinished"];
//}
//
//- (BOOL)isFinished {
//    return _finished;
//}

- (BOOL)isAsynchronous {
    return YES;
}

- (dispatch_semaphore_t)semaphore {
    return self.command.semaphore;
}

@end
