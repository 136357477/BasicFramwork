//
//  NSString+Base64.h
//  lecuntao
//
//  Created by guohui on 2016/12/14.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;
@end
