//
//  RCRTCCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCommand.h"

@interface RCRTCCommand ()
@property (nonatomic,   copy) NSArray *opNames;
@property (nonatomic, assign) RCRTCCommandExecuteType executeType;
@property (nonatomic, assign) BOOL isContinue;
@end

@implementation RCRTCCommand

+ (RCRTCCommand *)commandWithParams:(NSDictionary *)params
                        executeType:(RCRTCCommandExecuteType)executeType {
    RCRTCCommand *cmd = [RCRTCCommand new];
    cmd.params = params;
    cmd.executeType = executeType;
    cmd.isContinue = YES;
    return cmd;
}

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.params = params;
    }
    return self;
}

- (void)prepare {
    NSLog(@"cmd config op param");
}

- (void)finishedWithOpName:(NSString *)opName
                  response:(id)response
                isContinue:(BOOL)isContinue {
    self.isContinue = isContinue;
    NSLog(@"%@ op结束, 执行结果:%@, 是否继续执行剩下的op:%@", opName, response, @(isContinue));
}

- (void)completion {
    NSLog(@"cmd completion");
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ops:%@",self.opNames];
}



@end
