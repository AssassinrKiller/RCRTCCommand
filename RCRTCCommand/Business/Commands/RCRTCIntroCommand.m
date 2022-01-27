//
//  RCRTCIntroCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/27.
//

#import "RCRTCIntroCommand.h"

@interface RCRTCIntroCommand ()

@property (nonatomic, copy)void(^callback)(BOOL isSuccess, NSInteger code);

@end

@implementation RCRTCIntroCommand

- (void)prepare {
    NSMutableDictionary *opParams = [self.params mutableCopy];
    void(^sayHelloFinished)(NSString *result) = ^(NSString *result) {
        NSLog(@"%@",result);
    };
    [opParams setValue:sayHelloFinished forKey:@"sayHelloFinished"];
    self.params = opParams;
}

- (void)completion {
    if (self.callback) {
        self.callback(YES, 0);
    }
}

@end
