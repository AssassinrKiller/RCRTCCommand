//
//  RCRTCCommand.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCCommand : NSObject

@property (nonatomic,   copy) NSArray *opTypes;
//command 产生的 op 执行方式 0:依次执行前后依赖 1:并发执行前后依赖,都执行完通知
@property (nonatomic, assign) NSInteger executeType;
@property (nonatomic,   copy) NSDictionary *params;
@property (nonatomic,   weak) RCRTCCommand *prev;
@property (nonatomic, strong) RCRTCCommand *next;

+ (RCRTCCommand *)commandWithParams:(NSDictionary *)params
                            opTypes:(NSArray *)opTypes;

@end

NS_ASSUME_NONNULL_END
