//
//  RCRTCJoinRoomOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/9.
//

#import "RCRTCJoinRoomOperation.h"

@interface RCRTCJoinRoomOperation()
@property (nonatomic, copy)NSString *roomId;
@end

@implementation RCRTCJoinRoomOperation

- (void)prepare {
    self.roomId = self.command.params[@"roomId"];
//    NSLog(@"roomId:%@",self.roomId);
}

- (void)action {
//    NSLog(@"join room signal & media server");
    [self finishedAction];
}

- (NSString *)description {
    return @"join room";
}

@end
