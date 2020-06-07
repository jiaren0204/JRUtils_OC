//
//  NSString+JR.h
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JR)

- (NSString *)trim;    /**< 去除字符串首尾空格 */

- (CGSize)sizeWithMaxW:(CGFloat)maxW font:(UIFont *)font;
- (CGSize)sizeWithMaxH:(CGFloat)maxH font:(UIFont *)font;

- (NSString *)urlUTF8Encoding;

- (NSString *)md5String;        /**< MD5加密 */

+ (NSString *)convert_Time:(NSTimeInterval)second;  /**< 转换时间格式 */

@end

NS_ASSUME_NONNULL_END
