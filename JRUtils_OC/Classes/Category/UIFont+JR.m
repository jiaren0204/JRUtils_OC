//
//  UIFont+JR.m
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import "UIFont+JR.h"

@implementation UIFont (JR)

+ (void)logAll
{
    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
        printf("familyNames = %s\n",[familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for (NSString *fontName in fontNames) {
            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
    }
}

+ (UIFont *)font_ChalkboardSE_Bold_Size:(CGFloat)size
{
    return [UIFont fontWithName:kChalkboardSE_Bold size:size];
}

+ (UIFont *)font_ChalkboardSE_Regular_Size:(CGFloat)size
{
    return [UIFont fontWithName:kChalkboardSE_Regular size:size];
}

+ (UIFont *)font_PingFangSC_Regular_Size:(CGFloat)size
{
    return [UIFont fontWithName:kPingFangRegular size:size];
}

+ (UIFont *)font_PingFangSC_Medium_Size:(CGFloat)size
{
    return [UIFont fontWithName:kPingFangMedium size:size];
}

+ (UIFont *)font_PingFangSC_Semibold_Size:(CGFloat)size
{
    return [UIFont fontWithName:kPingFangSemibold size:size];
}

+ (UIFont *)font_Helvetica_Bold_Oblique_Size:(CGFloat)size
{
    return [UIFont fontWithName:kHelveticaBoldOblique size:size];
}

+ (UIFont *)font_Helvetica_Neue_Bold_Italic_Size:(CGFloat)size
{
    return [UIFont fontWithName:kHelveticaNeueBoldItalic size:size];
}

@end
