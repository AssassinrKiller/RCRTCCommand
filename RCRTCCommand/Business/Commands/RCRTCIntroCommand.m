//
//  RCRTCIntroCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/27.
//

#import "RCRTCIntroCommand.h"

@interface RCRTCIntroCommand ()

@property (nonatomic, copy)void(^callback)(BOOL isSuccess, NSInteger code, id response);

@end

@implementation RCRTCIntroCommand

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_Sync;
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
        self.callback(YES, 0, nil);
    }    
}

- (NSString *)cmdName {
    return @"Intro command";
}

@end
