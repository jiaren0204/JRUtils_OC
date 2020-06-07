//
//  NSString+JR.m
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import "NSString+JR.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (JR)

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (CGSize)sizeWithMaxW:(CGFloat)maxW font:(UIFont *)font
{
    CGSize size = CGSizeMake(maxW, MAXFLOAT);
    NSDictionary *textAttrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size;
}

- (CGSize)sizeWithMaxH:(CGFloat)maxH font:(UIFont *)font
{
    CGSize size = CGSizeMake(MAXFLOAT, maxH);
    NSDictionary *textAttrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading attributes:textAttrs context:nil].size;
}

- (NSString *)urlUTF8Encoding
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
}

- (NSString *)md5String
{
    if (self.length == 0) {
        return @"";
    }
    const char *str = [(NSString *)self UTF8String];

    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5(str, (CC_LONG)strlen(str), result);

    NSMutableString *ret = [NSMutableString string];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X", result[i]];
    }

    return ret;
}

+ (NSString *)convert_Time:(NSTimeInterval)second
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    
    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];
    
    if (second / 3600 >= 1) {
        dateFM.dateFormat = @"HH:mm:ss";
    }
    else {
        dateFM.dateFormat = @"mm:ss";
    }
    
    NSString *convertTime = [dateFM stringFromDate:date];
    
    return convertTime;
}


@end
