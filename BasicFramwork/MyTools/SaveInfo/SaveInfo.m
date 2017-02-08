//
//  SaveInfo.m
//  LXY
//
//  Created by guohui on 16/3/28.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import "SaveInfo.h"
#define KPASSWORD @"password"
#define LOGINNAME @"loginName"
#define TOKEN @"token"
#define USER_ID @"user_id"
#define USER_INFO @"userInfo"
#define SHOP_NAME @"shop_name"
#define USER_IMAGE_Url @"userImage_url"
#define PUSH_FLAG @"push_flag"
#define VERSION_BUILD @"Version(Build)"
#define PROVINC @"provinc"
#define CITY @"city"
@implementation SaveInfo
+ (SaveInfo *)shareSaveInfo{
    static SaveInfo *saveInfo = nil ;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        saveInfo = [[self alloc] init];
    });
    return saveInfo ;
}
- (BOOL)isFistStart{
    //此为找到plist文件中版本号所对应的键
    NSString *key = (NSString *)kCFBundleVersionKey ; //CFBundleVersion
    //从plist文件中取出版本号
    NSString *buildStr = [NSBundle mainBundle].infoDictionary[key];
    NSString *versionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *version = [NSString stringWithFormat:@"%@(%@)",versionStr,buildStr];
    //从沙盒中取出上次存储的版本号
    NSString *saveVersion = RETURE_MESSAGE(VERSION_BUILD);
//    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (![version isEqualToString:saveVersion]) {
        //将新版本号写入沙盒
        SAVE_MESSAGE(version, VERSION_BUILD);
    }
    return [version isEqualToString:saveVersion] ;
}

#pragma mark - get set 方法 -
- (void)setKey:(NSString *)key{
    SAVE_MESSAGE(key, KEY);
}
- (NSString *)key{
//    if (RETURE_MESSAGE(KEY) == nil) {
//        return @"" ;
//    }else{
        return RETURE_MESSAGE(KEY);
//    }
    
}

- (void)setLoginName:(NSString *)loginName{
    SAVE_MESSAGE(loginName, LOGINNAME);
}
- (NSString *)loginName{
    return RETURE_MESSAGE(LOGINNAME);
}

-(NSString *)passWord{
    return RETURE_MESSAGE(KPASSWORD);
}
- (void)setPassWord:(NSString *)passWord{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:passWord forKey:KPASSWORD];
//    [defaults synchronize];
    SAVE_MESSAGE(passWord, KPASSWORD);
}

- (void)setToken:(NSString *)token{
    SAVE_MESSAGE(token, TOKEN);
}
- (NSString *)token{
    return RETURE_MESSAGE(TOKEN);
}
- (void)setUser_id:(NSString *)user_id{
    SAVE_MESSAGE(user_id, USER_ID);

}
- (NSString *)user_id{
    if (RETURE_MESSAGE(USER_ID) == nil) {
        return @"0";
    }else{
        return RETURE_MESSAGE(USER_ID);
    }
}
- (void)setUserInfo:(NSDictionary *)userInfo{
    SAVE_MESSAGE(userInfo, USER_INFO);
}
- (NSDictionary *)userInfo{
    return RETURE_MESSAGE(USER_INFO);
}
- (void)setShop_name:(NSString *)shop_name{
    SAVE_MESSAGE(shop_name, SHOP_NAME);
}
- (NSString *)shop_name{
    return RETURE_MESSAGE(SHOP_NAME);
}

- (void)setUserImageUrl:(NSString *)userImageUrl{
    SAVE_MESSAGE(userImageUrl, USER_IMAGE_Url);
}
- (NSString *)userImageUrl{
    return RETURE_MESSAGE(USER_IMAGE_Url);
}

- (void)setPushFlag:(NSString *)pushFlag{
    SAVE_MESSAGE(pushFlag, PUSH_FLAG);
}
- (NSString *)pushFlag{
    return RETURE_MESSAGE(PUSH_FLAG);
}
-(void)setProvinc:(NSString *)provinc
{
    SAVE_MESSAGE(provinc, PROVINC);
}
-(NSString *)provinc
{
    if (RETURE_MESSAGE(PROVINC) == nil) {
        return @"140" ;
    }
    return RETURE_MESSAGE(PROVINC);
    
}
-(void)setCity:(NSString *)city
{
    SAVE_MESSAGE(city, CITY);
}
-(NSString *)city
{
    if (RETURE_MESSAGE(CITY) == nil) {
        return @"0";
    }
    return RETURE_MESSAGE(CITY);
}
-(void)setProvincName:(NSString *)provincName
{
    SAVE_MESSAGE(provincName, PROVINC_NAME);
}
-(NSString *)provincName
{
    return RETURE_MESSAGE(PROVINC_NAME);
}
-(void)setCityName:(NSString *)cityName
{
    SAVE_MESSAGE(cityName, CITY_NAME);
}
-(NSString *)cityName
{
    return RETURE_MESSAGE(CITY_NAME);
}
- (void)setMember_id:(NSString *)member_id{
    SAVE_MESSAGE(member_id, MEMBER_ID);
}
- (NSString *)member_id{
    if (RETURE_MESSAGE(MEMBER_ID) == nil) {
        return @"0";
    }else{
        return RETURE_MESSAGE(MEMBER_ID);
    }
}
- (void)logout{
    self.key = nil ;
    self.loginName = nil ;
    self.passWord = nil ;
    self.token = nil ;
    self.user_id = nil ;
    self.userInfo = nil ;
    self.shop_name = nil ;
    self.userImageUrl = nil ;
    self.pushFlag = nil ;
    self.member_id = nil ;
}



@end
