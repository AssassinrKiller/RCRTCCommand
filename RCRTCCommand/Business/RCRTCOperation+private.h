//
//  RCRTCOperation+private.h
//  RCRTCCommand
//
//  Created by huan xu on 2022/2/9.
//

#import "RCRTCOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCRTCOperation (private)

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) NSInteger code;
@property (assign) BOOL isExecuting;
@property (assign) BOOL isFinished;

@end

NS_ASSUME_NONNULL_END
