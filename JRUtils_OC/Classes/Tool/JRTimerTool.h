//
//  JRTimerTool.h
//  JRTimer
//
//  Created by 嘉仁 on 16/5/17.
//  Copyright © 2016年 嘉仁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRTimerTool : NSObject

+ (void)startDisplayLink:(id)obj block:(void(^)(CFTimeInterval duration))block;
+ (void)stopDisplayLinkWithKey:(NSString *)key;
+ (void)stopDisplayLink:(id)obj;


/**
 循环Timer
 
 @param timeInterval 间隔
 @param isImmediate 是否立刻执行
 */
+ (void)startTimer:(id)obj
      timeInterval:(NSTimeInterval)timeInterval
       isImmediate:(BOOL)isImmediate
             block:(void (^)(void))block;
/**
 循环Timer
 
 @param count 指定次数后停止
 */
+ (void)startTimer:(id)obj
      timeInterval:(NSTimeInterval)timeInterval
       isImmediate:(BOOL)isImmediate
             count:(NSInteger)count
             block:(void (^)(NSInteger curCount))block;

+ (void)stopTimer:(id)obj;
+ (void)stopTimerWithKey:(NSString *)key;

+ (void)addBlockOnDealloc:(id)obj key:(NSString *)key block:(void (^)(void))block;

/** 延时执行 **/
// 不覆盖
+ (void)dealyNoCover:(id)obj seconds:(NSTimeInterval)seconds block:(void (^)(void))block;
+ (void)cancelDealyWithNoCover:(id)obj;

// 覆盖
+ (void)dealyWithCover:(id)obj seconds:(NSTimeInterval)seconds block:(void (^)(void))block;
+ (void)cancelDealyWithCover:(id)obj;

+ (void)runWithGCD:(id)obj sec:(NSTimeInterval)sec isImmediate:(BOOL)isImmediate block:(void(^)(void))block;
+ (void)stopGCDTimer:(NSString *)key;


@end
