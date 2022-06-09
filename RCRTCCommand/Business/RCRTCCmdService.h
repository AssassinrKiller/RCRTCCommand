//
//  RCRTCCmdService.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "RCRTCDataSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^RCRTCCommandCompletion)(BOOL isSuccess,
                                      NSInteger code,
                                      id _Nullable response);

@interface RCRTCCmdService : NSObject

/// 开始执行 command
/// @param cmdName 自定义 cmd 名称
/// @param params 执行过程中需要的参数
/// @param completion 执行结束的回调
+ (void)commandWithCmdName:(NSString *)cmdName
                    params:(NSDictionary * _Nullable)params
                completion:(RCRTCCommandCompletion _Nullable)completion;

/// 取消当前所有的 cmd
+ (void)cancelCurrentCmd;

/// 检查还有未结束的 cmd
+ (void)checkCommandFinished;

/// 设置代理
/// @param delegate delegate
+ (void)setServiceDelegate:(id<RCRTCCmdServiceDelegate>)delegate;



@end

NS_ASSUME_NONNULL_END
