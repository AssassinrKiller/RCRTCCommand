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
    [RCRTCCmdService commandWithCmdName:@"Intro" params:@{@"name":@"xuhuan"} completion:^(BOOL isSuccess, NSInteger code) {
        NSLog(@"intro cmd 执行完成");
    }];
    
    [RCRTCCmdService commandWithCmdName:@"JoinRoom"
                                 params:@{@"roomId":@"333"}
                             completion:nil];
}




@end
