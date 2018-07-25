//
//  UIImageView+JKExtension.m
//  game
//
//  Created by 姜昆 on 2018/7/25.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import "UIImageView+JKExtension.h"
#import "UIImage+JKExtension.h"
#import "YYWebImage.h"

@implementation UIImageView (JKExtension)

- (void)jk_yysetImageWithUrl:(NSString *)string placeHolder:(NSString *)ph cornerRadius:(CGFloat)corner{
    [self yy_setImageWithURL:[NSURL URLWithString:string]
                 placeholder:[UIImage imageNamed:ph]
                     options:YYWebImageOptionSetImageWithFadeAnimation
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    }
                   transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                       return [image yy_imageByRoundCornerRadius:corner];
                   } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                       
                   }];
    
}


- (void)jk_setImgUrl:(NSString *)url placeHolder:(NSString *)holder{
    if ([url isEqual:[NSNull null]]) {
        return;
    }
    if (!url) {
        return;
    }
    NSString *str = nil;
    if (holder && holder.length >0) {
        str = holder;
    }else{
        str = @"mn_mrtx";
    }
    
    [self jk_yysetImageWithUrl:url placeHolder:str cornerRadius:0];
}
- (void)jk_setImgUrl:(NSString *)url placeHolder:(NSString *)holder cornerRadius:(CGFloat)corner{
    if ([url isEqual:[NSNull null]]) {
        return;
    }
    if (!url) {
        return;
    }
    NSString *str = nil;
    if (holder && holder.length >0) {
        str = holder;
    }else{
        str = @"mn_mrtx";
    }
    
    [self jk_yysetImageWithUrl:url placeHolder:str cornerRadius:corner];
}

- (void)jk_setCircleImgUrl:(NSString *)url placeHolder:(NSString *)holder{
    if ([url isEqual:[NSNull null]]) {
        return;
    }
    if (!url) {
        return;
    }
    NSString *str = nil;
    if (holder && holder.length >0) {
        str = holder;
    }else{
        str = @"mn_mrtx";
    }
    [self jk_setCircleImageWithUrlString:url placeholder:[UIImage imageNamed:str] fillColor:[UIColor clearColor] opaque:NO];
    
}

#pragma mark - inner function

- (void)jk_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color opaque:(BOOL)opaque{
    [self.superview layoutIfNeeded];
    NSURL *url = [NSURL URLWithString:urlString];
    //防止循环引用
    __weak typeof(self) weakSelf = self;
    CGSize size = self.frame.size;
    
    if (image) {
        //占位图片不为空的情况
        //1.现将占位图圆角化，这样就避免了如图片下载失败，使用占位图的时候占位图不是圆角的问题
        [image jk_roundImageWithSize:size fillColor:color opaque:opaque completion:^(UIImage *radiusPlaceHolder) {
            
            [weakSelf yy_setImageWithURL:url
                             placeholder:radiusPlaceHolder
                                 options:YYWebImageOptionSetImageWithFadeAnimation
                              completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                  
                                  [image jk_roundImageWithSize:size fillColor:color opaque:opaque completion:^(UIImage *radiusImage) {
                                      weakSelf.image = radiusImage;
                                  }];
                                  
                              }];
            
        }];
        
    } else {
        //占位图片为空的情况
        [weakSelf yy_setImageWithURL:url
                         placeholder:nil
                             options:YYWebImageOptionSetImageWithFadeAnimation
                          completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                              
                              [image jk_roundImageWithSize:size fillColor:color opaque:opaque completion:^(UIImage *radiusImage) {
                                  weakSelf.image = radiusImage;
                              }];
                              
                          }];
        
    }
}


- (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r
{
    int w = size.width*4;
    int h = size.height*4;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMaxX(rect), CGRectGetMaxX(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    //根据圆角路径绘制
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


@end
