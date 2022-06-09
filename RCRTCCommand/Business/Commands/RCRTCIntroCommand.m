//
//  RCRTCIntroCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/27.
//

#import "RCRTCIntroCommand.h"

@interface RCRTCIntroCommand ()
@property (nonatomic, strong) NSMutableDictionary *response;
@end

@implementation RCRTCIntroCommand

- (RCRTCCommandExecuteType)executeType {
    return RCRTCCommandExecuteType_Sync;
}

- (NSDictionary<NSString *,NSNumber *> *)sequenceDic {
    return @{@"SayHello":@(NSOperationQueuePriorityHigh),
             @"SayHi":@(NSOperationQueuePriorityNormal),
             @"End":@(NSOperationQueuePriorityNormal)};
}

- (NSArray *)opNames {
    return @[@"SayHello",@"SayHi",@"End"];
}

- (BOOL)isNeededSnapshot {
    return YES;
}

- (void)prepare {
    
}

- (void)processWithOpName:(NSString *)opName code:(NSInteger)code response:(id)response {
    if (code == 0) {
        if (![response isKindOfClass:NSDictionary.class]) {
            return;
        }
        for (NSString *key in response) {
            [self.response setObject:response[key] forKey:key];
        }
    }
    self.code = code;
}

- (void)finished {
    if (self.completion) {
        self.completion(self.code == 0, self.code, self.response);
    }    
}

- (NSMutableDictionary *)response {
    if (!_response) {
        _response = [NSMutableDictionary dictionary];
    }
    return _response;
}

@end
