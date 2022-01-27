//
//  RCRTCCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCommand.h"

@interface RCRTCCommand ()
@property (nonatomic,  copy) NSArray *opTypes;
@property (nonatomic,assign) RCRTCCommandExecuteType executeType;
//@property (nonatomic,  copy) NSDictionary *params;
@end

@implementation RCRTCCommand

+ (RCRTCCommand *)commandWithParams:(NSDictionary *)params
                            opTypes:(NSArray *)opTypes
                        executeType:(RCRTCCommandExecuteType)executeType {
    RCRTCCommand *cmd = [RCRTCCommand new];
    cmd.params = params;
    cmd.opTypes = opTypes;
    cmd.executeType = executeType;
    return cmd;
}

- (void)prepare {
    NSLog(@"cmd config op param");
}

- (void)completion {
    NSLog(@"cmd completion");
}

- (void (^)(void))finished {
    __weak typeof(self)weakSelf = self;
    return ^(void){
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf completion];
    };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ops:%@",self.opTypes];
}



@end
