//
//  NSString+extension.m
//  Extensions
//
//  Created by 姜昆 on 2018/7/23.
//  Copyright © 2018年 mingBo. All rights reserved.
//

#import "NSString+extension.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#import <sys/utsname.h>

@implementation NSString (extension)

/**
 * 判断是否为链接  http/https
 */
- (BOOL)isNormalLink{
    NSString *phoneRegex = @"^http[s]?:\/\/";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


- (BOOL)isTelephone
{
    /**
     * 正则：手机号（精确）
     * <p>移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188、198</p >
     * <p>联通：130、131、132、145、155、156、166、171、175、176、185、186</p >
     * <p>电信：133、153、173、177、180、181、189、199</p >
     * <p>全球星：1349</p >
     * <p>虚拟运营商：170</p >
     */
    
    NSString *phoneRegex = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
    
}

- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 * 判断数字字母下划线
 */
- (BOOL)isa_zA_S_Pwd{
    NSString *azAs_p = @"^[0-9a-zA-Z_]{1,}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", azAs_p];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)weakPswd
{
    NSString *pswdEx =
    @"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,20}$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pswdEx];
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isRealEmpty
{
    return self == nil || !([self length] > 0) || [[self trim] length] == 0;
}

- (BOOL)isIdentifyCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)isIdentifyCardStrict{
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

/**
 查找字符串 存不存在
  */
- (BOOL)seasonRangeOfString:(NSString *)titleStr{
    
    NSRange range = [self rangeOfString:titleStr];
    
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

/**
 * 文件大小
 */
- (long long)fileSize{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self]){
        return [[manager attributesOfItemAtPath:self error:nil] fileSize];
    }
    NSLog(@"当前路径无文件");
    return 0;
}



/**
 去除空格
 trim
 */
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 去除换行符与空格
 trim  '\n'
 */
- (NSString *)trimmedWhitespaceAndNewlineString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 to MD5
 */
- (NSString *)toMD5String
{
    const char *original_str = [self UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);//调用md5
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

/**
 * JSONstring -> 字典
 */
- (NSDictionary *)jsonToDictionary{
    
    if (self.length <= 0 || !self) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
  string size  for string
 
 @params size max size
 @params font font
 */
- (CGSize)boundingRectWithSize:(CGSize)size withFont:(NSFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine|
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}
/**
 string size  for attribute string
 
 @params size max size
 @params dic attributes
 */
- (CGSize)boundingRectWithSize:(CGSize)size attribute:(NSDictionary *)dic{
    CGSize retSize = [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine|
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:dic
                                        context:nil].size;
    
    return retSize;
}

/**
 attributed String with line space and font size
 为字符串添加行间距
 @params space line space
 @params font font
 */
- (NSAttributedString *)attributedStringWithLineSpace:(CGFloat)space fontSize:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = space;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self attributes:dic];
    return attributeStr;
}


/**
 * 格式化时间字符串
 **/
- (NSString *)formaterToPublishmentTimeWithIndex:(NSUInteger)index{
    NSMutableString *time = [NSMutableString string];
    NSString *toTime = [self substringToIndex:index];
    [time appendString:[toTime componentsSeparatedByString:@"T"][0]];
    [time appendString:@"\t"];
    [time appendString:[toTime componentsSeparatedByString:@"T"][1]];
    return time;
}

/**
 * 获取到某个长度的字符串
 **/
- (NSString *)jk_substringWithLength:(NSUInteger)length{
    NSMutableString *sub = [NSMutableString string];
    if (self.length>length) {
        [sub appendString:[self substringToIndex:length]];
        [sub appendString:@"..."];
        return sub;
    }else{
        return self;
    }
    
}
/**
 * 将\U0000ffc替换为[图片]
 **/
- (NSString *)jk_repla_U000fffc_toImg{
    [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    [self stringByReplacingOccurrencesOfString:@"\n" withString:@"\t"];
    return [self stringByReplacingOccurrencesOfString:@"\U0000fffc" withString:@"[图片]"];
}

/**
 * 通过字符串，font计算出行数
 **/
- (NSInteger)jk_numberOfLinesWithFont:(NSInteger)font
                         withWidth:(NSInteger)width{
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    CGFloat singleHight = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    
    NSInteger lines = size.height / singleHight;
    return lines;
}

/**
 get random string with length
 */
+ (NSInteger)jk_getRandomStringWithLength:(NSUInteger)length{
    return [self stringWithFormat:@"%s",genRandomString(length)];
}

char* genRandomString(unsigned long length)
{
    int flag, i;
    char* string;
    srand((unsigned) time(NULL ));
    if ((string = (char*) malloc(length)) == NULL )
    {
        return NULL ;
    }
    
    for (i = 0; i < length - 1; i++)
    {
        flag = rand() % 3;
        switch (flag)
        {
            case 0:
                string[i] = 'A' + rand() % 26;
                break;
            case 1:
                string[i] = 'a' + rand() % 26;
                break;
            case 2:
                string[i] = '0' + rand() % 10;
                break;
            default:
                string[i] = 'x';
                break;
        }
    }
    string[length - 1] = '\0';
    return string;
}

/**
 get device ip address
 */
+ (NSString *)jk_deviceIPAdress{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}



@end
