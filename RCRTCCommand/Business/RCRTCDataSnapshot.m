//
//  RCRTCDataSnapshot.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/25.
//

#import "RCRTCDataSnapshot.h"

@interface RCRTCDataSnapshot ()
@property (nonatomic, copy) NSString *currentUserId;
@property (nonatomic, copy) NSDictionary *originData;
@end

@implementation RCRTCDataSnapshot
@synthesize roomId = _roomId;

+ (instancetype)SnapshotWithData:(NSDictionary *)data {
    RCRTCDataSnapshot *snapshot = [self new];
    snapshot.originData = data;
    return snapshot;
}

- (NSString *)roomId {
    return _roomId;
}

- (void)setRoomId:(NSString *)roomId {
    if (_roomId != roomId) {
        _roomId = roomId;
    }
}

@end
