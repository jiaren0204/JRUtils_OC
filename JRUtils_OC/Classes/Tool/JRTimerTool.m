//
//  JRTimerTool.m
//  JRTimer
//
//  Created by 嘉仁 on 16/5/17.
//  Copyright © 2016年 嘉仁. All rights reserved.
//

#import "JRTimerTool.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSMutableDictionary<NSString *, NSTimer *> *_timerList = nil;

@interface JRTimerToolAutoRemove : NSObject
@property (nonatomic, copy) void (^performDealloc)(void);
@end

@implementation JRTimerToolAutoRemove
- (void)dealloc
{
    if (self.performDealloc) {
        self.performDealloc();
    }
}
@end


static NSMutableDictionary<NSString *, CADisplayLink *> *_displayLinkList = nil;
@interface JRDisplayLinkHandle : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) void (^block)(CFTimeInterval duration);
@end

@implementation JRDisplayLinkHandle

+ (instancetype)createWithKey:(NSString *)key block:(void(^)(CFTimeInterval))block
{
    JRDisplayLinkHandle *handle = [JRDisplayLinkHandle new];
    handle.key = key;
    handle.block = block;
    return handle;
}

- (void)onFrame
{
    CADisplayLink *displayLink = _displayLinkList[self.key];
    
    if (displayLink && self.block) {
        self.block(displayLink.duration);
    }
}
@end


@interface JRTimerToolHandle : NSObject
@property (nonatomic, copy) void (^block)(void);
@end

@implementation JRTimerToolHandle

- (void)onTimer
{
    if (_block) {
        _block();
    }
}

@end

@implementation JRTimerTool


+ (void)startDisplayLink:(id)obj block:(void(^)(CFTimeInterval duration))block
{
    NSString *key = [NSString stringWithFormat:@"%p",obj];
    
    JRDisplayLinkHandle *handle = [JRDisplayLinkHandle createWithKey:key block:block];

    if (_displayLinkList == nil) {
        _displayLinkList = [NSMutableDictionary new];
    }
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:handle selector:@selector(onFrame)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    _displayLinkList[key] = displayLink;
    
    [JRTimerTool addBlockOnDealloc:obj key:@"startDisplayLink" block:^{
        
        [JRTimerTool stopDisplayLinkWithKey:key];
    }];
}

+ (void)stopDisplayLinkWithKey:(NSString *)key
{
    CADisplayLink *displayLink = _displayLinkList[key];
    if (displayLink) {
        [displayLink invalidate];
        [_displayLinkList removeObjectForKey:key];
    }
}

+ (void)stopDisplayLink:(id)obj
{
    NSString *key = [NSString stringWithFormat:@"%p",obj];
    [JRTimerTool stopDisplayLinkWithKey:key];
}

+ (void)addBlockOnDealloc:(id)obj key:(NSString *)key block:(void (^)(void))block
{
    if (obj == nil) {
        return;
    }
    const char *obj_key = [key UTF8String];
    
    JRTimerToolAutoRemove *autoRemove = objc_getAssociatedObject(obj, obj_key);
    
    if (autoRemove == nil) {
        autoRemove = [JRTimerToolAutoRemove new];
        autoRemove.performDealloc = block;
        objc_setAssociatedObject(obj, obj_key, autoRemove, OBJC_ASSOCIATION_RETAIN);
    }
}

+ (void)startTimer:(id)obj
      timeInterval:(NSTimeInterval)timeInterval
       isImmediate:(BOOL)isImmediate
             count:(NSInteger)count
             block:(void (^)(NSInteger curCount))block
{
    __block NSInteger curCount = 0;
    
    __weak typeof(obj) weakObj = obj;
    [JRTimerTool startTimer:obj timeInterval:timeInterval isImmediate:isImmediate block:^{
        ++curCount;
        if (block) {
            block(curCount);
        }
        __strong typeof(obj) strongOjb = weakObj;
        if (curCount >= count) {
            [JRTimerTool stopTimer:strongOjb];
        }
    }];
}

+ (void)startTimer:(id)obj
      timeInterval:(NSTimeInterval)timeInterval
       isImmediate:(BOOL)isImmediate
             block:(void (^)(void))block
{
    if (block && isImmediate) {
        block();
    }
    
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    
    if (_timerList == nil) {
        _timerList = [NSMutableDictionary new];
    }
    
    if (_timerList[key] != nil) {
        [JRTimerTool stopTimerWithKey:key];
    }
    
    JRTimerToolHandle *handle = [JRTimerToolHandle new];
    handle.block = block;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:handle selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timerList[key] = timer;
    
    [JRTimerTool addBlockOnDealloc:obj key:@"startTimer" block:^{
        [JRTimerTool stopTimerWithKey:key];
    }];
}

+ (void)stopTimer:(id)obj
{
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    [JRTimerTool stopTimerWithKey:key];
}

+ (void)stopTimerWithKey:(NSString *)key
{
    NSTimer *timer = _timerList[key];
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
        
        [_timerList removeObjectForKey:key];
    }
}

static NSMutableDictionary<NSString *, NSMutableArray<NSTimer *> *> *__dealyNoCover = nil;
+ (void)dealyNoCover:(id)obj seconds:(NSTimeInterval)seconds block:(void (^)(void))block
{
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    
    if (__dealyNoCover == nil) {
        __dealyNoCover = [NSMutableDictionary new];
    }
    
    if (__dealyNoCover[key] == nil) {
        __dealyNoCover[key] = [NSMutableArray new];
    }
    
    JRTimerToolHandle *handle = [JRTimerToolHandle new];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:handle selector:@selector(onTimer) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [__dealyNoCover[key] addObject:timer];
    
    handle.block = ^{
        if (block) {
            block();
        }
        
        [timer invalidate];
        [__dealyNoCover[key] removeObject:timer];
    };
    
    [JRTimerTool addBlockOnDealloc:obj key:@"dealyNoCover" block:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray<NSTimer *> *arr = __dealyNoCover[key];
            
            [arr enumerateObjectsUsingBlock:^(NSTimer * _Nonnull t, NSUInteger idx, BOOL * _Nonnull stop) {
                [t invalidate];
            }];
            
            [__dealyNoCover removeObjectForKey:key];
        });
    }];
}

+ (void)cancelDealyWithNoCover:(id)obj
{
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    
    NSArray<NSTimer *> *timerArr = __dealyNoCover[key];
    [timerArr enumerateObjectsUsingBlock:^(NSTimer * _Nonnull t, NSUInteger idx, BOOL * _Nonnull stop) {
        [t invalidate];
    }];
    
    [__dealyNoCover removeObjectForKey:key];
}


static NSMutableDictionary<NSString *, NSTimer *> *__dealyWithCoverDic = nil;
+ (void)dealyWithCover:(id)obj seconds:(NSTimeInterval)seconds block:(void (^)(void))block
{
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    
    if (__dealyWithCoverDic == nil) {
        __dealyWithCoverDic = [NSMutableDictionary new];
    }
    
    if (__dealyWithCoverDic[key] != nil) {  // 覆盖 停止之前的
        [__dealyWithCoverDic[key] invalidate];
    }
    
    JRTimerToolHandle *handle = [JRTimerToolHandle new];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:handle selector:@selector(onTimer) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    __dealyWithCoverDic[key] = timer;
    
    handle.block = ^{
        if (block) {
            block();
        }
        [__dealyWithCoverDic[key] invalidate];
        [__dealyWithCoverDic removeObjectForKey:key];
    };
    
    [JRTimerTool addBlockOnDealloc:obj key:@"dealyWithCover" block:^{
        [__dealyWithCoverDic[key] invalidate];
        [__dealyWithCoverDic removeObjectForKey:key];
    }];
}

+ (void)cancelDealyWithCover:(id)obj
{
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    NSTimer *timer = __dealyWithCoverDic[key];
    if (timer) {
        [timer invalidate];
        [__dealyWithCoverDic removeObjectForKey:key];
    }
}

static NSMutableDictionary<NSString *, NSMutableArray<dispatch_source_t> *> *__gcdTimerDic = nil;
static dispatch_queue_t __removeKeyQueue;
+ (void)runWithGCD:(id)obj sec:(NSTimeInterval)sec isImmediate:(BOOL)isImmediate block:(void(^)(void))block
{
    NSString *key = [NSString stringWithFormat:@"%p", obj];
    
    if (__gcdTimerDic == nil) {
        __gcdTimerDic = [NSMutableDictionary new];
    }
    
    if (__gcdTimerDic[key] == nil) {
        __gcdTimerDic[key] = [NSMutableArray new];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("runWithGCD",dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_DEFAULT, 0));
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t start = isImmediate ? DISPATCH_TIME_NOW : dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC);
    dispatch_source_set_timer(timer, start, sec * NSEC_PER_SEC, 0);
    
    
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
    
    dispatch_resume(timer);
    
    [__gcdTimerDic[key] addObject:timer];
    
    [JRTimerTool addBlockOnDealloc:obj key:@"runWithHz" block:^{
        [JRTimerTool stopGCDTimer:key];
    }];
}

+ (void)stopGCDTimer:(id)obj
{
    NSString *key = [obj isKindOfClass:[NSString class]] ? obj : [NSString stringWithFormat:@"%p", obj];
    
    if (__removeKeyQueue == nil) {
        __removeKeyQueue = dispatch_queue_create("stopGCDTimer",dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_DEFAULT, 0));
    }
    
    dispatch_async(__removeKeyQueue, ^{
        NSMutableArray<dispatch_source_t> *sources = __gcdTimerDic[key];
        [sources enumerateObjectsUsingBlock:^(dispatch_source_t  _Nonnull time, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_source_cancel(time);
        }];
        
        [__gcdTimerDic removeObjectForKey:key];
    });
}

@end
