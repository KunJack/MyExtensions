//
//  NSString+extension.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>


@interface NSString (extension)

/**
 * 判断是否为链接  http/https
 */
- (BOOL)isNormalLink;

/**
 * 判断手机号是否正确
 */
- (BOOL)isTelephone;

/**
 * 判断邮箱是否在正确
 */
- (BOOL)isEmail;

/**
 * 判断数字字母下划线
 */
- (BOOL)isa_zA_S_Pwd;

/**
 * 弱密码判断
 */
- (BOOL)weakPswd;

/**
 * 字符串是否为空（未初始化，空字符串）
 */
- (BOOL)isRealEmpty;

/**
 * 身份证验证简单版
 */
- (BOOL)isIdentifyCard;

/**
 * 身份证验证完整版
 */
- (BOOL)isIdentifyCardStrict;

/**
 check string in another string
  查找字符串 存不存在
 */
- (BOOL)seasonRangeOfString:(NSString *)titleStr;

/**
 get file size with file path
 * 使用文件路径获取
 */
- (long long)fileSize;

/**
  去除空格
  trim
 */
- (NSString *)trim;

/**
  去除换行符与空格
 trim  '\n'
 */
- (NSString *)trimmedWhitespaceAndNewlineString;

/**
 to MD5
 */
- (NSString *)toMD5String;

/**
 * JSON string -> dictionary
 */
- (NSDictionary *)jsonToDictionary;

/**
 string size  for string
 字符串size
 @params size max size
 @params font font
 */
- (CGSize)boundingRectWithSize:(CGSize)size withFont:(NSFont *)font;

/**
 string size  for attribute string
 
 @params size max size
 @params dic attributes
 */
- (CGSize)boundingRectWithSize:(CGSize)size attribute:(NSDictionary *)dic;

/**
 attributed String with line space and font size
 为字符串添加行间距
 @params space line space
 @params font font
 */
- (NSAttributedString *)attributedStringWithLineSpace:(CGFloat)space fontSize:(UIFont *)font;

/**
 formater time string 
  格式化时间字符串
 **/
- (NSString *)formaterToPublishmentTimeWithIndex:(NSUInteger)index;

/**
 * 获取到某个长度的字符串
 **/
- (NSString *)jk_substringWithLength:(NSUInteger)length;

/**
 * 将\U0000ffc替换为[图片]
 **/
- (NSString *)jk_repla_U000fffc_toImg;

/**
 get number of lines with font and max width
通过字符串，font计算出行数
 */
- (NSInteger)jk_numberOfLinesWithFont:(NSInteger)font
                         withWidth:(NSInteger)width;

/**
 get random string with length
 */
+ (NSInteger)jk_getRandomStringWithLength:(NSUInteger)length;

/**
 get device ip address
 */
+ (NSString *)jk_deviceIPAdress;








@end
