//
//  ViewController.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "ViewController.h"
#import "RCRTCCmdService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [RCRTCCmdService commandAWithParams:@{@"name":@"xuhuan"} completion:^(BOOL isSuccess, NSInteger code) {
        NSLog(@"命令A 执行回调");
    }];
    
    [RCRTCCmdService commandBWithParams:@{@"roomId":@"12345"} completion:^(BOOL isSuccess, NSInteger code) {
        NSLog(@"命令B 执行回调");
    }];
}


@end
