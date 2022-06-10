//
//  RCRTCCmdManager.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCmdManager.h"
#import "RCRTCCommand+private.h"
#import "RCRTCOperation.h"

@interface RCRTCCmdManager ()
@property (nonatomic, weak) RCRTCCommand *currentCmd;
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
    [self setDependencyWithOps:ops];
    [self fetchCmdSnapshot];
    dispatch_semaphore_signal(_semaphore);
    return ops;
}

- (NSMutableArray<RCRTCOperation *> *)fetchOperationInternal {
    RCRTCCommand *cmd = _head.next;
    NSMutableArray<RCRTCOperation *> *ops = [NSMutableArray array];
    
    if (cmd.status == RCRTCCommandStatus_Discard) {
        NSLog(@"pendingCommand:%@, should be discard", cmd.cmdName);
        [self sortWithCommand:cmd];
        return [self fetchOperationInternal];
    }
    
    for (NSString *opName in cmd.opNames) {
        NSString *classStr = [NSString stringWithFormat:@"RCRTC%@Operation",opName];
        Class class = NSClassFromString(classStr);
        if (!class) {
            NSLog(@"undefined operation, please check it");
            continue;
        }
        RCRTCOperation *op = [class new];
        op.name = opName;
        op.command = cmd;
        op.queuePriority = (NSOperationQueuePriority)[cmd.sequenceDic[opName] integerValue];
        [ops addObject:op];
    }
    
    if (!ops.count) return nil;
    
    if (ops.count == cmd.opNames.count) {
        self.currentCmd = cmd;
    }
    
    [self sortWithCommand:cmd];
    
    return ops;
}

- (void)sortWithCommand:(RCRTCCommand *)cmd {
    if (--_cmdCount == 0) {
        _head.next = _tail;
        _tail.prev = _head;
    } else {
        _head.next = cmd.next;
        cmd.next.prev = _head;
    }
}

- (void)setDependencyWithOps:(NSArray *)ops{
    RCRTCCommandExecuteType executeType = self.currentCmd.executeType;
    switch (executeType) {
        case RCRTCCommandExecuteType_Sync:
        {
            RCRTCOperation *lastOp = nil;
            for (RCRTCOperation *op in ops) {
                if (lastOp) {
                    [op addDependency:lastOp];
                }
                lastOp = op;
            }
        }
            break;
        case RCRTCCommandExecuteType_Custom:
        {
            //需要添加复杂的依赖关系 queuePriority 只能决定开始的顺序, addDependency 才能决定结束的顺序
            for (NSInteger i = 0; i < ops.count; i++) {
                RCRTCOperation *op_i = [ops objectAtIndex:i];
                for (NSInteger j = 0; j < ops.count; j++) {
                    if (i == j) continue;
                    RCRTCOperation *op_j = [ops objectAtIndex:j];
                    if (op_i.queuePriority > op_j.queuePriority) {
                        [op_j addDependency:op_i];
                    } else if (op_i.queuePriority < op_j.queuePriority) {
                        [op_i addDependency:op_j];
                    }
                }
//                NSLog(@"op:%@ 的依赖:%@", op_i.name, op_i.dependencies);
            }
        }
            break;
        default:
            break;
    }
}

- (void)fetchCmdSnapshot {
    if (!self.currentCmd.isNeededSnapshot) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(fetchSnapshot)]) {
        self.currentCmd.snapshot = [self.delegate fetchSnapshot];
    }
}


- (void)push:(RCRTCCommand *)command {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    [self optimizeWithCommand:command];
    
    RCRTCCommand *last = _tail.prev;
    _tail.prev = command;
    command.next = _tail;
    command.prev = last;
    last.next = command;
    
    ++_cmdCount;
    
    dispatch_semaphore_signal(_semaphore);
}

- (void)optimizeWithCommand:(RCRTCCommand *)command {
    if ([self.delegate respondsToSelector:@selector(willPushCommand:inQueue:)]) {
        NSMutableArray *queue = [NSMutableArray array];
        RCRTCCommand *current = _head.next;
        while (current != _tail) {
            [queue addObject:current];
            current = current.next;
        }
        [self.delegate willPushCommand:command inQueue:queue];
    }
}

- (void)showAllCommands {
//    NSLog(@"pendingCommandCount:%@", @(_cmdCount));
    RCRTCCommand *current = _head.next;
    while (current != _tail) {
        NSLog(@"pendingCommand:%@", current);
        current = current.next;
    }
}

@end
