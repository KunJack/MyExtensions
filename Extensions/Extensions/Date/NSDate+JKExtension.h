//
//  NSDate+JKExtension.h
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
