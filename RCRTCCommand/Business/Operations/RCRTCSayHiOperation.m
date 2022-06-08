//
//  RCRTCSayHiOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCSayHiOperation.h"
@implementation RCRTCSayHiOperation

- (void)prepare {
//    NSLog(@"say hi --- 开始执行");
}

- (void)action {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(3);
//        NSLog(@"耗时操作 say Hi");
        [self finishedAction];
    });
}

- (NSString *)description {
    return @"say hi";
}

@end
