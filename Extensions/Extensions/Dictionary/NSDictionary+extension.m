//
//  NSDictionary+extension.m
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
