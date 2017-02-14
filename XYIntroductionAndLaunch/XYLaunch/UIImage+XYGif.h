//
//  UIImage+XYGif.h
//  XYLaunchAndIntroductionExample
//
//  Created by XY Lv on 17/2/14.
//  Copyright © 2017年 吕欣宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
@interface UIImage (XYGif)
+ (UIImage *)xy_setAnimatedGIFWithGifName:(NSString *)name;

+ (UIImage *)xy_setAnimatedGIFWithData:(NSData *)data;

+ (float)xy_setFrameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source;

@end
