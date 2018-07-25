//
//  NSDate+JKExtension.h
//  game
//
//  Created by 姜昆 on 2018/7/25.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JKExtension)


/**
 * a string descript date like 'yyyy-MM-dd HH:mm'
 */
+ (NSString *)jk_nowDateStringWithFormater:(NSString *)formater;

/**
 timestamp with millisecond (13)
 */
+ (NSUInteger)jk_timestampMillisecond;

/**
 timestamp (10)
 */
+ (NSUInteger)jk_timestamp;

@end
