//
//  NSDate+JR.m
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import "NSDate+JR.h"

@implementation NSDate (JR)


- (NSString *)ymdhmsStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:self];
}

- (NSString *)ymdhmStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:self];
}


- (NSString *)ymdStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString *)ymdChineseStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:self];
}

- (NSString *)ymStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:self];
}

- (NSString *)ymChineseStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    return [formatter stringFromDate:self];
}

- (NSString *)hmStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:self];
}


- (NSDate *)tomorrow
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:self];
    [components setHour:24];
    return [cal dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)yesterday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:self];
    [components setHour:-24];
    return [cal dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)thisWeek
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger weekDay = [components weekday];
    NSInteger day = [components day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1; weekDay == 1 == 周日
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [cal firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    
    //获取周一日期
    [components setDay:day + firstDiff];
    
    return [cal dateFromComponents:components];
}

- (NSDate *)lastWeek
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setDay:([components day] - 7)];
    return [cal dateFromComponents:components];
}

- (NSDate *)nextWeek
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setDay:([components day] + 6)];
    return [cal dateFromComponents:components];
}

- (NSDate *)lastMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setMonth:([components month] - 1)];
    return [cal dateFromComponents:components];
}

- (NSDate *)thisMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setMonth:([components month])];
    return [cal dateFromComponents:components];
}

- (NSDate *)nextMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setMonth:([components month] + 1)];
    return [cal dateFromComponents:components];
}

+ (NSDate *)dateStrToDate:(NSString *)str
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    return [formatter dateFromString:str];
}

- (NSInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;

    NSDateComponents *cmps = [calendar components:unit fromDate:self];

    return cmps.month;
}

- (NSInteger)getDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;

    NSDateComponents *cmps = [calendar components:unit fromDate:self];

    return cmps.day;
}

- (BOOL)isThisYear
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy:MM:dd";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *createCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == createCmps.year;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;

    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];

    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

- (BOOL)isSameDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;

    NSDateComponents *nowCmps = [calendar components:unit fromDate:date];

    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];

    fmt.dateFormat = @"yyyy-MM-dd";

    NSString *selfStr = [fmt stringFromDate:self];

    return [fmt dateFromString:selfStr];
}

- (BOOL)isYesterday
{
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];

    return cmps.day == 1;
}

+ (NSString *)getTimestamp
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger time = interval;
    return [NSString stringWithFormat:@"%zd",time];
}

@end
