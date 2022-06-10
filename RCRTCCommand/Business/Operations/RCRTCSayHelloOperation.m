//
//  RCRTCSayHelloOperation.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCSayHelloOperation.h"

@interface  RCRTCSayHelloOperation()
@end

@implementation RCRTCSayHelloOperation

- (void)prepare {
//    NSLog(@"say hello --- 开始执行");
    NSString *roomId = self.command.snapshot.roomId;
    NSLog(@"roomId:%@",roomId);
}

- (void)action {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"耗时操作 say hello");
        self.isSuccess = YES;
        self.code = 0;
        self.response = @{@"name":@"xuhuan"};
        [self finishedAction];
    });
}


@end
