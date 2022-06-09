//
//  RCRTCCommand.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "RCRTCCmdService.h"
#import "RCRTCDataSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RCRTCCommandExecuteType) {
    RCRTCCommandExecuteType_Sync   = 0,  //依次执行前后依赖
    RCRTCCommandExecuteType_Async  = 1,  //并发执行, 都执行完通知
    RCRTCCommandExecuteType_Custom = 2   //自定义执行顺序
};

typedef NS_ENUM(NSInteger, RCRTCCommandStatus) {
    RCRTCCommandStatus_Normal   = 0,   //正常需要执行的
    RCRTCCommandStatus_Invaild  = 1,   //以失败执行结束
    RCRTCCommandStatus_Discard  = 2    //未执行,可以丢弃
};

@protocol  RCRTCCommandInterface <NSObject>

/// 子任务未开始之前先执行, 修改或调整参数
- (void)prepare;

/// 当子任务执行结束当前 command 收到回调
/// @param opName 对应的 op 名称
/// @param code op 执行结果 0 成功, 非 0 失败
/// @param response op 执行需要传递给到 cmd 的结果
- (void)processWithOpName:(NSString *)opName
                     code:(NSInteger)code
                 response:(nullable id)response;

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
 自定义任务执行顺序,当 executeType == RCRTCCommandExecuteType_Custom 生效.
 设置系统优先级, 如下:
 @"OP1":@(NSOperationQueuePriorityHigh),
 @"OP2":@(NSOperationQueuePriorityHigh),
 @"OP3":@(NSOperationQueuePriorityNormal)
 */
- (NSDictionary<NSString *,NSNumber *> *)sequenceDic;

@end

@interface RCRTCCommand : NSObject <RCRTCCommandInterface>

@property (nonatomic,   copy) NSString *cmdName;
@property (nonatomic, assign) RCRTCCommandStatus status;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id<RCRTCDataSnapshotInterface> snapshot;
@property (nonatomic, readonly,   copy) NSDictionary *params;
@property (nonatomic, readonly,   copy) void(^processing)(void);
@property (nonatomic, readonly,   copy) RCRTCCommandCompletion completion;
@property (nonatomic, readonly, assign) BOOL isContinue;

@end

NS_ASSUME_NONNULL_END
