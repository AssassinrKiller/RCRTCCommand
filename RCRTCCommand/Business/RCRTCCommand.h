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

@property (nonatomic, readonly,   copy) NSArray *opNames;
@property (nonatomic, readonly, assign) RCRTCCommandExecuteType executeType;
@property (nonatomic, readonly, assign) BOOL isContinue;
@property (nonatomic, readonly, strong) id response;

@property (nonatomic, copy) NSDictionary *params;

@property (nonatomic,   weak) RCRTCCommand *prev;
@property (nonatomic, strong) RCRTCCommand *next;

- (instancetype)initWithParams:(NSDictionary *)params;

- (void)prepare;

- (void)finishedWithOpName:(NSString *)opName
                  response:(id)response
                isContinue:(BOOL)isContinue;

- (void)completion;

@end

NS_ASSUME_NONNULL_END
