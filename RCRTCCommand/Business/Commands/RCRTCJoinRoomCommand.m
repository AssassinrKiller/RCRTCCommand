//
//  RCRTCJoinRoomCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/9.
//

#import "RCRTCJoinRoomCommand.h"

@implementation RCRTCJoinRoomCommand

- (NSArray *)opNames {
    return @[@"JoinRoom"];
}

- (void)prepare {
    
}

- (void)fetchOpName:(NSString *)opName response:(id)response{
    
}

- (void)finished {
    
}

- (NSString *)description {
    return @"join room command";
}

@end
