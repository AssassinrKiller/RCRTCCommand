//
//  ViewController.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "ViewController.h"
#import "RCRTCCmdService.h"
#import "RCRTCLeaveRoomCommand.h"

@interface ViewController ()<RCRTCCmdServiceDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RCRTCCmdService setServiceDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [RCRTCCmdService commandWithCmdName:@"Intro" params:@{@"name":@"xuhuan"} completion:^(BOOL isSuccess, NSInteger code, id  _Nullable response) {
        NSLog(@"isSuccess:%@ --- response:%@",isSuccess ? @"成功" : @"失败", response);
    }];
    
    [RCRTCCmdService commandWithCmdName:@"JoinRoom"
                                 params:@{@"roomId":@"333"}
                             completion:nil];
    
    [RCRTCCmdService commandWithCmdName:@"JoinRoom"
                                 params:@{@"roomId":@"333"}
                             completion:nil];
    
//    [RCRTCCmdService commandWithCmdName:@"LeaveRoom"
//                                 params:@{@"roomId":@"333"}
//                             completion:nil];
}


- (id<RCRTCDataSnapshotInterface>)fetchSnapshot {
    return nil;
}

- (void)willPushCommand:(RCRTCCommand *)command inQueue:(NSArray *)queue {
//    NSLog(@"currentCmd:%@ allCmd:%@",command, queue);
    //如果遇到离开房间,在此之前未执行的cmd都抛弃
    if ([command isKindOfClass:RCRTCLeaveRoomCommand.class]) {
        for (RCRTCCommand *cmd in queue) {
            cmd.status = RCRTCCommandStatus_Discard;
        }
    }
}

@end
