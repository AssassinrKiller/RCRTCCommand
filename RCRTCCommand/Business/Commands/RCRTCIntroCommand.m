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

- (void)dealloc {
    NSLog(@"RCRTCIntroCommand dealloc");
}

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_custom;
}

- (NSDictionary<NSString *,NSNumber *> *)sequenceDic {
    return @{@"SayHello":@(NSOperationQueuePriorityNormal),
             @"SayHi":@(NSOperationQueuePriorityNormal),
             @"End":@(NSOperationQueuePriorityHigh)};
}

- (NSArray *)opNames {
    return @[@"SayHello",@"SayHi",@"End"];
}

- (void)prepare {
    self.callback = self.params[@"callback"];
}

- (void)fetchOpResponse:(id)response {
    NSLog(@"response:%@",response);
}

- (void)finished {
    if (self.callback) {
        self.callback(YES, 0);
    }    
}

@end
