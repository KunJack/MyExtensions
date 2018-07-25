//
//  UIImage+JKExtension.h
//  game
//
//  Created by 姜昆 on 2018/7/25.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKExtension)

/*
 circle image
 圆形图片
 @params size target size
 @params fillColor fillColor
 @params opaque isOpaque
 @params completion finish
 */
- (void)jk_roundImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque completion:(void (^)(UIImage *))completion;
/*
 coner round rect image
 圆角矩形
 @params size target size
 @params fillColor fillColor
 @params opaque isOpaque
 @params completion finish
 */
- (void)jk_roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque radius:(CGFloat)radius completion:(void (^)(UIImage *))completion;

/*
 fix the image orientation
 修复ios图片拍摄过程中
 @params size target size
 @params fillColor fillColor
 @params opaque isOpaque
 @params completion finish
 */
- (UIImage *)jk_fixOrientation;

/*
 load gif image with data
 加载gif
 @params data data
 */
+ (UIImage *)jk_animatedGIFWithData:(NSData *)data;

@end
