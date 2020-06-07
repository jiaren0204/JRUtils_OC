//
//  UIImage+JR.h
//  JRUtils_OC
//
//  Created by 梁嘉仁 on 2020/6/7.
//  Copyright © 2020 梁嘉仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <CoreMedia/CMSampleBuffer.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JR)

/** 压缩图片到指定大小(单位KB) */
+ (NSData *)resetSizeOfImage:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;

+ (UIImage *)imageWithStretchableImageName:(NSString *)name;

- (UIImage *)scaledToSize:(CGSize)size;

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

- (UIImage *)circleImage;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 重绘图片颜色
 */
- (UIImage *)imageWithColor:(UIColor *)tintColor;


/**
 将UIImage转换为CVPixelBufferRef

 @param size 转化后的大小
 @return 返回CVPixelBufferRef
 */
- (CVPixelBufferRef)pixelBufferRefWithSize:(CGSize)size;


/**
 将CMSampleBufferRef转换为UIImage

 @param sampleBuffer  sampleBuffer数据
 @return 返回UIImage
 */
+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;


/**
 将CVPixelBufferRef转换为UIImage

 @param pixelBuffer pixelBuffer 数据
 @return 返回UIImage
 */
+ (UIImage*)imageFromPixelBuffer:(CVPixelBufferRef)pixelBuffer;


@end

NS_ASSUME_NONNULL_END
