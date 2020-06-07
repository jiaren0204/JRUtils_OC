//
//  NSDate+JR.h
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JR)

- (NSString *)ymdhmsStr;
- (NSString *)ymdhmStr;
- (NSString *)ymdStr;
- (NSString *)ymdChineseStr;
- (NSString *)ymStr;
- (NSString *)ymChineseStr;
- (NSString *)hmStr;

- (NSDate *)tomorrow;
- (NSDate *)yesterday;
- (NSDate *)thisWeek;
- (NSDate *)lastWeek;
- (NSDate *)nextWeek;
- (NSDate *)lastMonth;
- (NSDate *)thisMonth;
- (NSDate *)nextMonth;

+ (NSDate *)dateStrToDate:(NSString *)str;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isSameDay:(NSDate *)date;
- (NSInteger)getMonth;
- (NSInteger)getDay;

+ (NSString *)getTimestamp;

@end

NS_ASSUME_NONNULL_END
