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
        sleep(4);
        NSLog(@"耗时操作 say hello");
        self.response = @"xuhuan";
        self.isContinue = YES;
        [self finishedAction];
    });
}

- (NSString *)description {
    return @"say hello";
}

@end
