//
//  RCRTCCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCommand.h"
#import "RCRTCCmdService.h"

@interface RCRTCCommand ()
@property (nonatomic, copy) NSDictionary *params;
@property (nullable, nonatomic, copy) RCRTCCommandCompletion completion;
@property (nullable, nonatomic, copy) void(^processing)(void);
@property (nonatomic,   weak) RCRTCCommand *prev;
@property (nonatomic, strong) RCRTCCommand *next;
@end

@implementation RCRTCCommand{
    BOOL _isContinue;
}

@synthesize isContinue = _isContinue;

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

- (instancetype)initWithParams:(NSDictionary *)params
                    processing:(void(^)(void))processing
                    completion:(RCRTCCommandCompletion)completion {
    if (self = [super init]) {
        self.params = params;
        self.processing = processing;
        self.completion = completion;
        self.isContinue = YES;
        [self prepareToExecute];
    }
    return self;
}

- (void)prepareToExecute {
    NSLog(@"%@ prepare", self.cmdName);
    [self prepare];
}

- (void)finishedWithOpName:(NSString *)opName
                  isSucess:(BOOL)isSucess
                   errCode:(NSInteger)errCode
                  response:(nullable id)response {
    NSLog(@"%@ child operation:[%@] is finished, code:%@", self.cmdName, opName, @(errCode));
    if (self.executeType == RCRTCCommandExecuteType_Sync) {
        self.isContinue = errCode == 0 ? YES : NO;
    }
    [self processWithOpName:opName code:errCode response:response];
}

- (void)commandFinished {
    NSLog(@"%@ completion", self.cmdName);
    [self finished];
}

#pragma mark - RCRTCCommandInterface
- (void)prepare {
    
}

- (void)processWithOpName:(NSString *)opName code:(NSInteger)code response:(id)response {
    
}

- (void)finished {
    
}

- (NSArray *)opNames {
    return @[];
}

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_Sync;
}

- (NSDictionary<NSString *,NSNumber *> *)sequenceDic {
    return nil;
}

- (BOOL)isNeededSnapshot {
    return YES;
}

#pragma mark - private
- (void)setIsContinue:(BOOL)isContinue {
    @synchronized (self) {
        _isContinue = isContinue;
    };
}

- (BOOL)isContinue {
    return _isContinue;
}

- (NSString *)description {
    NSString *status = @"";
    switch (self.status) {
        case RCRTCCommandStatus_Normal:
            status = @"Normal status";
            break;
        case RCRTCCommandStatus_Invaild:
            status = @"Invaild status";
            break;
        case RCRTCCommandStatus_Discard:
            status = @"Discard status";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@: %p ,%@ ,params:%@, ops:%@",
            self.cmdName ,self, status, self.params, self.opNames];
}

- (NSString *)cmdName {
    return NSStringFromClass(self.class);
}

- (RCRTCCommandCompletion)completion {
    return _completion;
}

- (void (^)(void))processing {
    return _processing;
}

@end
