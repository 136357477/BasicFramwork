//
//  GHTimeTool.h
//  LXY
//
//  Created by guohui on 16/7/23.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DAYFORMATEDEFAULT @"yyyy-MM-dd HH:mm:ss"
#define DAYFORMATE2 @"MM-dd HH:mm:ss"
@interface GHTimeTool : NSObject

#pragma mark date
+ (NSDate *)stringToDate:(NSString *)string andDateFormat:(NSString *)dateFormat ;

+ (NSString *)dateToString:(NSDate *)date andDateFormat:(NSString *)dateFormat ;
/**
 *  日期格式的转化  time = 1429164801 转换为时间
 */
+ (NSString *)StringToString:(NSString *)dateStr andDateFormat:(NSString *)dateFormat ;

// 获取当前时间
+ (NSString*)getCurrentTime ;
// 获取当前时间戳
+ (NSString*)getCurrentTimestamp ;
//把时间戳转化为时间
+ (NSString*)SetTime:(NSString*)time ;


@end
