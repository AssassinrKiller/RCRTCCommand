//
//  RCRTCCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCommand.h"
#import "RCRTCCmdService.h"

@interface RCRTCCommand ()
@property (nonatomic,   copy) NSDictionary *params;
@property (nonatomic, assign) BOOL isContinue;
@end

@implementation RCRTCCommand

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.params = params;
        self.isContinue = YES;
        [self prepareToExecute];
    }
    return self;
}

- (void)prepareToExecute {
    NSLog(@"%@ prepare", self);
    [self prepare];
}

- (void)finishedWithOpName:(NSString *)opName
                  response:(id)response
                isContinue:(BOOL)isContinue {
    NSLog(@"%@ child operation:[%@] is finished, to be continue:%@", self, opName, @(isContinue));
    self.isContinue = isContinue;
    if (response) {
        [self fetchOpName:opName response:response];
    }
}

- (void)completion {
    NSLog(@"%@ completion", self);
    [self finished];
}

#pragma mark - RCRTCCommandInterface
- (void)prepare {
    NSLog(@"%@ prepare", self);
}

- (void)fetchOpName:(NSString *)opName response:(id)response {
    
}

- (void)finished {
    
}

- (NSArray *)opNames {
    return @[];
}

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_sync;
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

@end
