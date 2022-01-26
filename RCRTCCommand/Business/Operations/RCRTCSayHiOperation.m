//
//  RCRTCSayHiOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCSayHiOperation.h"

@implementation RCRTCSayHiOperation
- (void)prepare {
//    NSLog(@"%@",self.command.params);
}

- (void)action {
    NSLog(@"say hi --- 开始执行");
    sleep(2);
    [self finishedAction];
}

- (NSString *)description {
    return @"say hi";
}

@end
