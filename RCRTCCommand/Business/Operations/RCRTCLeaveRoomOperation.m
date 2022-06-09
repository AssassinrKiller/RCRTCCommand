//
//  RCRTCLeaveRoomOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/6/9.
//

#import "RCRTCLeaveRoomOperation.h"

@implementation RCRTCLeaveRoomOperation

- (void)prepare {
    NSLog(@"离开房间");
}

- (void)action {
    [self finishedAction];
}

@end
