//
//  RCRTCCommand.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "RCRTCDataSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RCRTCCommandExecuteType) {
    RCRTCCommandExecuteType_sync   = 0,  //依次执行前后依赖
    RCRTCCommandExecuteType_async  = 1,  //并发执行, 都执行完通知
    RCRTCCommandExecuteType_custom = 2   //自定义执行顺序
};

@protocol  RCRTCCommandInterface <NSObject>

/// 子任务未开始之前先执行, 修改或调整参数
- (void)prepare;

/// 当子任务执行结束当前 command 收到回调
/// @param opName 对应的 op 名称
/// @param response op 执行需要传递给到 cmd 的结果
- (void)fetchOpName:(NSString *)opName response:(id)response;

/// 所有的子任务都执行完成回调
- (void)finished;

/// 需要构建的 operation 名称数组
- (NSArray *)opNames;

/// command 包含的 operation 执行方式, 默认是 RCRTCCommandExecuteType_sync
- (RCRTCCommandExecuteType)executeType;

/// 是否需要数据快照
- (BOOL)isNeededSnapshot;

@optional;
/*
 自定义任务执行顺序,当 executeType == RCRTCCommandExecuteType_custom 生效.
 设置系统优先级, 如下:
 @{@"SayHello":@(NSOperationQueuePriorityHigh),
 @"SayHi":@(NSOperationQueuePriorityHigh),
 @"End":@(NSOperationQueuePriorityNormal)}
 */
- (NSDictionary<NSString *,NSNumber *> *)sequenceDic;

@end

@interface RCRTCCommand : NSObject <RCRTCCommandInterface>

@property (nonatomic,   weak) RCRTCCommand *prev;
@property (nonatomic, strong) RCRTCCommand *next;

@property (nonatomic, strong) id<RCRTCDataSnapshotInterface> snapshot;
@property (nonatomic, readonly,  copy) NSDictionary *params;
@property (nonatomic, readonly, assign) BOOL isContinue;

@end

NS_ASSUME_NONNULL_END
