//
//  RCRTCCmdService.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCCmdService : NSObject

/// 开始执行 command
/// @param cmdName 自定义 cmd 名称
/// @param params 执行过程中需要的参数
/// @param completion 执行结束的回调
+ (void)commandWithCmdName:(NSString *)cmdName
                    params:(NSDictionary *)params
                completion:(id)completion;

/// 取消当前所有的 cmd
+ (void)cancelCurrentCmd;

/// 检查还有未结束的 cmd
+ (void)checkCommandFinished;

@end

NS_ASSUME_NONNULL_END
