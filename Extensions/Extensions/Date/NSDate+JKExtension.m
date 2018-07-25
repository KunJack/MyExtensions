//
//  NSDate+JKExtension.m
//

#import "NSDate+JKExtension.h"

@implementation NSDate (JKExtension)

+ (NSString *)jk_nowDateStringWithFormater:(NSString *)formater{
    NSString *temp = @"yyyy年MM月dd日 HH:mm";
    if (formater && formater.length>0) {
        temp = formater;
    }
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:temp];
    // 毫秒值转化为秒
    NSDate* date = [self date];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}

+ (NSUInteger)jk_timestampMillisecond{
    return  [[self dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000;
}

+ (NSUInteger)jk_timestamp{
    return  [[self dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
}



@end
