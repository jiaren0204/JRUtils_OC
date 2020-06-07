//
//  NSDictionary+JR.h
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JR)

- (NSString *)stringValue:(id)key;
- (NSNumber *)numberValue:(id)key;
- (NSArray *)arrayValue:(id)key;
- (NSDictionary *)dicValue:(id)key;

@end

NS_ASSUME_NONNULL_END
