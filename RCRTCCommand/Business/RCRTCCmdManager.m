//
//  RCRTCCmdManager.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCmdManager.h"
#import "RCRTCCommand.h"
#import "RCRTCSayHiOperation.h"
#import "RCRTCSayHelloOperation.h"
#import "RCRTCEndOperation.h"

@interface RCRTCCmdManager ()
@property (nonatomic, strong) RCRTCCommand *currentCmd;
@end

@implementation RCRTCCmdManager
{
    dispatch_semaphore_t _semaphore;
    RCRTCCommand *_head;
    RCRTCCommand *_tail;
    NSInteger _cmdCount;
    BOOL _isCancelled;
}

- (instancetype)init {
    if (self = [super init]) {
        _semaphore = dispatch_semaphore_create(1);
        _head = [RCRTCCommand new];
        _tail = [RCRTCCommand new];
        _head.next = _tail;
        _tail.prev = _head;
    }
    return self;
}

- (NSArray<RCRTCOperation *> *)fetchOperations {
    NSMutableArray<RCRTCOperation *> *ops = nil;
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    ops = [self fetchOperationInternal];
    dispatch_semaphore_signal(_semaphore);
    return ops;
}

- (NSMutableArray<RCRTCOperation *> *)fetchOperationInternal {
    RCRTCCommand *cmd = _head.next;
    NSMutableArray<RCRTCOperation *> *ops = [NSMutableArray array];
    
    NSOperation *lastOp = nil;
    
    for (NSString *opName in cmd.opNames) {
        NSString *classStr = [NSString stringWithFormat:@"RCRTC%@Operation",opName];
        Class class = NSClassFromString(classStr);
        if (!class) {
            NSLog(@"未找到对应 operation 请检查相关 command");
            continue;
        }
        RCRTCOperation *op = [class new];
        op.name = opName;
        op.command = cmd;
        [op setCompletionBlock:^{
//            NSLog(@"--- completion");
        }];
        if (lastOp && cmd.executeType == RCRTCCommandExecuteType_sync) {
            [op addDependency:lastOp];
        }
        lastOp = op;
        [ops addObject:op];
    }
    
    if (!ops.count) return nil;
    
    if (ops.count == cmd.opNames.count) {
        self.currentCmd = cmd;
    }
    
    if (--_cmdCount == 0) {
        _head.next = _tail;
        _tail.prev = _head;
    } else {
        _head.next = cmd.next;
        cmd.next.prev = _head;
    }
    
    return ops;
}

- (void)push:(RCRTCCommand *)command {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    RCRTCCommand *last = _tail.prev;
    _tail.prev = command;
    command.next = _tail;
    command.prev = last;
    last.next = command;
    
    ++_cmdCount;
    
    dispatch_semaphore_signal(_semaphore);
}

@end
