//
//  RCRTCSayHelloOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCSayHelloOperation.h"

@interface  RCRTCSayHelloOperation()
@end

@implementation RCRTCSayHelloOperation

- (void)prepare {
    NSLog(@"say hello --- 开始执行");
}

- (void)action {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(3);
        NSLog(@"耗时操作 say hello");
        self.isSuccess = YES;
        [self finishedAction];
    });
}

- (NSString *)description {
    return @"say hello";
}

@end
