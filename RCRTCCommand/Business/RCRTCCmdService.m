//
//  RCRTCCmdService.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCmdService.h"
#import "RCRTCCmdManager.h"
#import "RCRTCCommand+private.h"

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

+ (void)checkCommandFinished {
    [[RCRTCCmdService shareInstance] tryToFetch];
}

+ (void)cancelCurrentCmd {
    [[RCRTCCmdService shareInstance].runQueue cancelAllOperations];
}

- (instancetype)init {
    if (self = [super init]) {
        _runQueue = [NSOperationQueue new];
        _manager = [RCRTCCmdManager new];
        _fetchQueue = dispatch_queue_create("fetchCommand.queue", DISPATCH_QUEUE_SERIAL);
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
            NSLog(@"current command executing, operations:%@",strongSelf.runQueue.operations);
            return;
        }
        [strongSelf fetchOperations];
    });
}

- (void)fetchOperations {
#if DEBUG
//    [_manager showAllCommands];
#endif
    NSArray *ops = [_manager fetchOperations];
    
    for (NSOperation *op in ops) {
        [self.runQueue addOperation:op];
    }
    __weak typeof(self)weakSelf = self;
    
    if (!ops.count) return;
    
    [self.runQueue addBarrierBlock:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.manager.currentCmd commandFinished];
        [strongSelf tryToFetch];
    }];
}

+ (void)commandWithClass:(Class)cmdClass
                  params:(nullable NSDictionary *)params
              completion:(nullable RCRTCCommandCompletion)completion {
    [self commandWithClass:cmdClass params:params processing:nil completion:completion];
}

+ (void)commandWithClass:(Class)cmdClass
                  params:(nullable NSDictionary *)params
              processing:(nullable void(^)(void))processing
              completion:(nullable RCRTCCommandCompletion)completion {
    RCRTCCommand *cmd = [[cmdClass alloc] initWithParams:params.mutableCopy
                                              processing:processing
                                              completion:completion];
    [[RCRTCCmdService shareInstance] addCommand:cmd];
}

+ (void)setServiceDelegate:(id<RCRTCCmdServiceDelegate>)delegate {
    [RCRTCCmdService shareInstance].manager.delegate = delegate;
}

@end
