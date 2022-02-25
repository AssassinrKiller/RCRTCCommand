//
//  RCRTCCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCommand.h"
#import "RCRTCCmdService.h"

@interface RCRTCCommand ()
@property (nonatomic,   copy) NSDictionary *params;
@property (nonatomic, assign) BOOL isContinue;
@end

@implementation RCRTCCommand

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.params = params;
        self.isContinue = YES;
    }
    return self;
}

- (void)start {
    NSLog(@"cmd 开始执行");
    [self prepare];
}

- (void)finishedWithOpName:(NSString *)opName
                  response:(id)response
                isContinue:(BOOL)isContinue {
    NSLog(@"当前 command 子任务 %@ 结束, 是否继续执行:%@", opName, @(isContinue));
    self.isContinue = isContinue;
    if (response) {
        [self fetchOpName:opName response:response];
    }
}

- (void)completion {
    NSLog(@"cmd completion");
    [self finished];
}

#pragma mark - RCRTCCommandInterface
- (void)prepare {
    
}

- (void)fetchOpName:(NSString *)opName response:(id)response {
    
}

- (void)finished {
    
}

- (NSArray *)opNames {
    return @[];
}

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_sync;
}

- (NSDictionary<NSString *,NSNumber *> *)sequenceDic {
    return nil;
}

- (BOOL)isNeededSnapshot {
    return YES;
}

#pragma mark - private
- (void)setIsContinue:(BOOL)isContinue {
    @synchronized (self) {
        //假设 2个 op 并发, 只要有一个 op 失败, cmd 的 isContinue = NO
        if (!_isContinue) return;
        _isContinue = isContinue;
    };
}

@end
