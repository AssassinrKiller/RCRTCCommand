//
//  RCRTCEndOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCEndOperation.h"

@implementation RCRTCEndOperation

- (void)prepare {
    NSLog(@"end --- 开始执行");
}

- (void)action {
    [self finishedAction];
}

- (NSString *)description{
    return @"end";
}

@end
