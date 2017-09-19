//
//  NSString+NumberOfs.m
//  ios_test_01
//
//  Created by xubojoy on 2017/8/21.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "NSString+NumberOfs.h"

@implementation NSString (NumberOfs)


- (NSString *)reverse{
//计算字符串的长度
    NSInteger length = self.length;
//   取出一个字符串中的每一个字符
    unichar *buffer = calloc(length, sizeof(unichar));
//    反转字符串的长度
    [self getCharacters:buffer range:NSMakeRange(0, length)];
    
    for (NSInteger i = 0; i < length/2; i ++) {
        unichar temp = buffer[i];
        buffer[i] = buffer[length-1-i];
        buffer[length-1-i] = temp;
    }
//    得到反转后的字符串
    NSString *result = [NSString stringWithCharacters:buffer length:length];
//    释放对象
    free(buffer);
    return result;
}


+ (NSString *)reverseString:(NSString *)string{

   return [string reverse];
}


@end
