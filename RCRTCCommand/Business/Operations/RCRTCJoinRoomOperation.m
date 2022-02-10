//
//  RCRTCJoinRoomOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/9.
//

#import "RCRTCJoinRoomOperation.h"

@implementation RCRTCJoinRoomOperation

- (void)prepare {
    
}

- (void)action {
    NSLog(@"join room signal & media server");
    [self finishedAction];
}

- (NSString *)description {
    return @"加房间";
}

@end
