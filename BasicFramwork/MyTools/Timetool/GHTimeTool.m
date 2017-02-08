


//
//  GHTimeTool.m
//  LXY
//
//  Created by guohui on 16/7/23.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import "GHTimeTool.h"

@implementation GHTimeTool
#pragma mark -
#pragma mark date

+ (NSDate *)stringToDate:(NSString *)string andDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:dateFormat];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString *)dateToString:(NSDate *)date andDateFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:dateFormat];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

//- (NSString *)geShiHuaShiJian:(NSString *)tempTime{
//    //日期格式的转化  time = 1429164801 转换为
//    //时间
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
//    [formatter setTimeZone:timeZone];
//    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
//    
//    float time = [tempTime floatValue];
//    time = time/1000;
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
//    NSString *str = [formatter stringFromDate:confromTimesp];
//    
//    return str ;
//    
//    
//}
+ (NSString *)StringToString:(NSString *)dateStr andDateFormat:(NSString *)dateFormat{
    float time = [dateStr floatValue];
//    time = time/1000;
    NSDate *temp_date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *string = [self dateToString:temp_date andDateFormat:dateFormat];
    return string ;
}

// 获取当前时间
+ (NSString*)getCurrentTime {
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyMMddHHmmss"];
    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
    NSLog(@"当前时间是===%@",dateTime);
    return dateTime;
    
}
// 获取当前时间戳
+ (NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//把时间戳转化为时间
+ (NSString*)SetTime:(NSString*)time{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyMMdd"];
    int timeval = [time intValue];
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeval];
    NSLog(@"confromTimesp  = %@",confromTimesp);
    NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}












@end
