//
//  RCRTCEndOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCEndOperation.h"

@implementation RCRTCEndOperation

- (void)prepare {
//    NSLog(@"end --- 开始执行");
}

- (void)action {
    NSLog(@"end 请求操作");
    self.isSuccess = YES;
    self.code = 0;
    self.response = @{@"birthday":@"19910825"};
    [self finishedAction];
}

@end
