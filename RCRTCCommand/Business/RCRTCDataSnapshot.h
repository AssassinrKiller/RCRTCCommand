//
//  RCRTCDataSnapshot.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RCRTCDataSnapshotInterface <NSObject>

@property (nonatomic, copy) NSString *roomId;

@property (nonatomic, readonly, copy) NSString *currentUserId;

@end

@protocol RCRTCCmdServiceDelegate <NSObject>

- (id<RCRTCDataSnapshotInterface>)fetchSnapshot;

@end

@interface RCRTCDataSnapshot : NSObject <RCRTCDataSnapshotInterface>

+ (instancetype)SnapshotWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
