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

- (NSArray *)opNames {
    return @[@"SayHello",@"SayHi"];
}

- (void)prepare {
    self.callback = self.params[@"callback"];
}

- (void)finishedWithOpName:(NSString *)opName
                  response:(id)response
                isContinue:(BOOL)isContinue {
    [super finishedWithOpName:opName response:response isContinue:isContinue];
    NSLog(@"response:%@",response);
}

- (void)completion {
    if (self.callback) {
        self.callback(YES, 0);
    }
}

@end
