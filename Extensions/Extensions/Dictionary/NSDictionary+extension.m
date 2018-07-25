//
//  NSDictionary+extension.m
//  game
//
//  Created by 姜昆 on 2018/7/23.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import "NSDictionary+extension.h"

@implementation NSDictionary (extension)

- (NSString *)toJsonString {
    if (!self || self.count<=0) {
        return @"";
    }
    
    NSError* parseError = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return str;
}

@end
