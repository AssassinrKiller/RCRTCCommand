//
//  RCRTCCommand.m
//  RCRTCCommand
//
//  Created by huan xu on 2022/1/25.
//

#import "RCRTCCommand.h"

@implementation RCRTCCommand

+ (RCRTCCommand *)commandWithParams:(NSDictionary *)params
                            opTypes:(NSArray *)opTypes {
    RCRTCCommand *cmd = [RCRTCCommand new];
    cmd.params = params;
    cmd.opTypes = opTypes;
    return cmd;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ops:%@",self.opTypes];
}



@end
