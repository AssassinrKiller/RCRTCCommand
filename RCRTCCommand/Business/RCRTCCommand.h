//
//  RCRTCCommand.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//command 产生的 op 执行方式
typedef NS_ENUM(NSInteger, RCRTCCommandExecuteType) {
    RCRTCCommandExecuteType_sync  = 0, //依次执行前后依赖
    RCRTCCommandExecuteType_async      //并发执行, 都执行完通知
};

@interface RCRTCCommand : NSObject

@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, readonly, copy) NSArray *opTypes;
@property (nonatomic, readonly,assign) RCRTCCommandExecuteType executeType;
@property (nonatomic,   copy) void(^finished)(void);
@property (nonatomic, strong) id response;

@property (nonatomic,   weak) RCRTCCommand *prev;
@property (nonatomic, strong) RCRTCCommand *next;

+ (RCRTCCommand *)commandWithParams:(NSDictionary *)params
                            opTypes:(NSArray *)opTypes
                        executeType:(RCRTCCommandExecuteType)executeType;

- (void)prepare;

- (void)completion;

@end

NS_ASSUME_NONNULL_END
