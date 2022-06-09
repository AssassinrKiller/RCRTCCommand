//
//  RCRTCCommand+private.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/10.
//

#import "RCRTCCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCCommand (private)

@property (nonatomic,   weak) RCRTCCommand *prev;
@property (nonatomic, strong) RCRTCCommand *next;

- (instancetype)initWithParams:(NSDictionary *)params
                    completion:(RCRTCCommandCompletion)completion;

- (void)finishedWithOpName:(NSString *)opName
                  isSucess:(BOOL)isSucess
                   errCode:(NSInteger)errCode
                  response:(nullable id)response;
    
- (void)commandFinished;

@end

NS_ASSUME_NONNULL_END
