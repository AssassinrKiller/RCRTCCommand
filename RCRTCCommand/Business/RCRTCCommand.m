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
        [self fetchOpResponse:response];
    }
}

- (void)completion {
    NSLog(@"cmd completion");
    [self finished];
}

#pragma mark - RCRTCCommandInterface
- (void)prepare {
    
}

- (void)fetchOpResponse:(id)response {
    
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


@end
