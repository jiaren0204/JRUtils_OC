//
//  UIFont+JR.h
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const kChalkboardSE_Bold = @"ChalkboardSE-Bold";
static NSString *const kChalkboardSE_Regular = @"ChalkboardSE-Regular";

static NSString *const kPingFangRegular = @"PingFangSC-Regular";
static NSString *const kPingFangMedium = @"PingFangSC-Medium";
static NSString *const kPingFangSemibold = @"PingFangSC-Semibold";

static NSString *const kHelveticaBoldOblique = @"Helvetica-BoldOblique";
static NSString *const kHelveticaNeueBoldItalic = @"HelveticaNeue-BoldItalic";

@interface UIFont (JR)

+ (void)logAll;


+ (UIFont *)font_ChalkboardSE_Bold_Size:(CGFloat)size;
+ (UIFont *)font_ChalkboardSE_Regular_Size:(CGFloat)size;

+ (UIFont *)font_PingFangSC_Regular_Size:(CGFloat)size;
+ (UIFont *)font_PingFangSC_Medium_Size:(CGFloat)size;
+ (UIFont *)font_PingFangSC_Semibold_Size:(CGFloat)size;

+ (UIFont *)font_Helvetica_Bold_Oblique_Size:(CGFloat)size;
+ (UIFont *)font_Helvetica_Neue_Bold_Italic_Size:(CGFloat)size;


@end

NS_ASSUME_NONNULL_END
