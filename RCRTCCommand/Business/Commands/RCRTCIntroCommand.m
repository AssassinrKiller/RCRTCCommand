//
//  RCRTCIntroCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/27.
//

#import "RCRTCIntroCommand.h"

@interface RCRTCIntroCommand ()

@property (nonatomic, copy)void(^callback)(BOOL isSuccess, NSInteger code);

@end

@implementation RCRTCIntroCommand

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_sync;
}

- (NSDictionary<NSString *,NSNumber *> *)sequenceDic {
    return @{@"SayHello":@(NSOperationQueuePriorityHigh),
             @"SayHi":@(NSOperationQueuePriorityNormal),
             @"End":@(NSOperationQueuePriorityNormal)};
}

- (NSArray *)opNames {
    return @[@"SayHello",@"SayHi",@"End"];
}

- (BOOL)isNeededSnapshot {
    return YES;
}

- (void)prepare {
    self.callback = self.params[@"callback"];
}

- (void)fetchOpName:(NSString *)opName response:(id)response {
    NSLog(@"%@ => response:%@", opName, response);
}

- (void)finished {
    if (self.callback) {
        self.callback(YES, 0);
    }    
}

- (NSString *)description {
    return @"intro command";
}

@end
