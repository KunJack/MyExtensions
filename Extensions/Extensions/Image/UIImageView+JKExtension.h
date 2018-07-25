//
//  UIImageView+JKExtension.h
//  game
//
//  Created by 姜昆 on 2018/7/25.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JKExtension)

/*
 use YYImage framework set image
 设置图片
 @params url target url
 @params holder placeholder url
 */
- (void)jk_setImgUrl:(NSString *)url placeHolder:(NSString *)holder;
/*
 use YYImage framework set image
 设置图片
 @params url target url
 @params holder placeholder url
 @params corner corner radius
 */
- (void)jk_setImgUrl:(NSString *)url placeHolder:(NSString *)holder cornerRadius:(CGFloat)corner;
/*
 use YYImage framework set circle image
 设置图片
 @params url target url
 @params holder placeholder url
 */
- (void)jk_setCircleImgUrl:(NSString *)url placeHolder:(NSString *)holder;

@end
