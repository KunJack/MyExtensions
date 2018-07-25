//
//  UIButton+JKExtension.h
//  game
//
//  Created by 姜昆 on 2018/7/25.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JKExtension)

/*
 拓展按钮相应热区

 @params top    topsize
 @params right  right
 @params bottom bottom
 @params left   left
 */
- (void)jk_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

/*
 拓展按钮相应热区
 
 @params size   side long
 */
- (void)jk_setEnlargeEdge:(CGFloat) size;

@end
