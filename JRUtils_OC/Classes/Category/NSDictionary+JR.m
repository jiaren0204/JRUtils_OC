//
//  NSDictionary+JR.m
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import "NSDictionary+JR.h"

@implementation NSDictionary (JR)

- (NSString *)stringValue:(id)key
{
    if (key == nil) { return @"";}
    
    NSString *item = self[key];
    if(item==nil || [item isKindOfClass:[NSString class]]==NO){
        item = @"";
    }
    return item;
}

- (NSNumber *)numberValue:(id)key
{
    if (key == nil) { return @0;}
    
    NSNumber *item = self[key];
    if(item==nil || [item isKindOfClass:[NSNumber class]]==NO){
        item = @0;
    }
    return item;
}

- (NSArray *)arrayValue:(id)key
{
    if (key == nil) { return [NSArray new];}
    
    NSArray *item = self[key];
    if(item==nil || [item isKindOfClass:[NSArray class]]==NO){
        item = [NSArray new];
    }
    return item;
}

- (NSDictionary *)dicValue:(id)key
{
    if (key == nil) { return [NSDictionary new];}
    
    NSDictionary *item = self[key];
    if(item==nil || [item isKindOfClass:[NSDictionary class]]==NO){
        item = [NSDictionary new];
    }
    return item;
}


@end
