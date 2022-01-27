//
//  RCRTCCmdService.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCmdService.h"
#import "RCRTCCmdManager.h"
#import "RCRTCCommand.h"
#import "RCRTCIntroCommand.h"

@interface RCRTCCmdService ()
@property (nonatomic, strong) NSOperationQueue *runQueue;
@property (nonatomic, strong) RCRTCCmdManager *manager;
@end

@implementation RCRTCCmdService
{
    dispatch_queue_t _fetchQueue;
}

+ (instancetype)shareInstance {
    static RCRTCCmdService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _runQueue = [NSOperationQueue new];
        _manager = [RCRTCCmdManager new];
        _fetchQueue = dispatch_queue_create("fetchCmd.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)addCommand:(RCRTCCommand *)command {
    [_manager push:command];
    [self tryToFetch];
}

- (void)tryToFetch {
    __weak typeof(self)weakSelf = self;
    dispatch_async(_fetchQueue, ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.runQueue.operationCount) {
            NSLog(@"正在执行当前 command");
            return;
        }
        [strongSelf fetchOperations];
    });
}

+ (void)checkCommandFinished {
    [[RCRTCCmdService shareInstance] tryToFetch];
}

- (void)fetchOperations {
    NSArray *ops = [_manager fetchOperations];
    for (NSOperation *op in ops) {
        [self.runQueue addOperation:op];
    }
    __weak typeof(self)weakSelf = self;
    [self.runQueue addBarrierBlock:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.manager.currentCmd.finished();
//        [strongSelf tryToFetch];//执行下一个 cmd
    }];
    NSLog(@"currentQueueCount:%@",@(self.runQueue.operationCount));
}

+ (void)commandAWithParams:(NSDictionary *)params
                completion:(void(^)(BOOL isSuccess, NSInteger code))completion {
    NSMutableDictionary *opParams = params.mutableCopy;
    RCRTCCommand *cmd = [RCRTCIntroCommand commandWithParams:opParams
                                                opTypes:@[@"SayHello",@"SayHi"]
                                            executeType:RCRTCCommandExecuteType_async];
    [cmd prepare];
    [[RCRTCCmdService shareInstance] addCommand:cmd];
}

+ (void)commandBWithParams:(NSDictionary *)params
                completion:(void(^)(BOOL isSuccess, NSInteger code))completion {
    NSMutableDictionary *opParams = params.mutableCopy;
    if (completion) {
        [opParams setObject:completion forKey:@"callback"];
    }
    RCRTCCommand *cmd = [RCRTCCommand commandWithParams:opParams
                                                opTypes:@[@"End"]
                                            executeType:RCRTCCommandExecuteType_sync];
    [[RCRTCCmdService shareInstance] addCommand:cmd];
}

@end
