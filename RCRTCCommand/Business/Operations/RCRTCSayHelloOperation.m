//
//  RCRTCSayHelloOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCSayHelloOperation.h"

@interface  RCRTCSayHelloOperation()

@property (nonatomic, copy)void(^callback)(BOOL isSuccess, NSInteger code);

@end

@implementation RCRTCSayHelloOperation


- (void)prepare {
    self.callback = self.command.params[@"callback"];
    NSLog(@"say hello --- 开始执行");
}

- (void)action {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"耗时操作");
        [self finishedAction];
    });
}

- (NSString *)description {
    return @"say hello";
}

@end
