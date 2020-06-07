//
//  NSURL+JR.m
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import "NSURL+JR.h"

@implementation NSURL (JR)

+ (NSURL*)urlWithResourceFile:(NSString*)filename
{
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], filename];
    return [NSURL fileURLWithPath:path];
}

@end
