//
//  AppDelegate.m
//  BasicFramwork
//
//  Created by guohui on 2017/1/19.
//  Copyright © 2017年 guohui. All rights reserved.
//

#import "AppDelegate.h"
#import <UIViewController+Swizzled.h>
#import "Common.h"
#import <Bugly/Bugly.h>
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate ()<BuglyDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic ,strong)Reachability *conn;
@end
/**
 Reachability 的网络判断
 */
static BOOL internetActive = YES;
static NetworkStatus hostReachState=NotReachable;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark -- 崩溃日志
    [self setupBugly];
    // Override point for customization after application launch.
#pragma mark -- 监听进入哪个类
    SWIZZ_IT_WITH_TAG(LOGTAG);
#pragma mark -- 网络监听
    // 监听网络状态改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    // 创建Reachability
    self.conn = [Reachability reachabilityForInternetConnection];
    self.conn = [Reachability reachabilityWithHostName:@"apilct.lecuntao.com"];
    // 开始监控网络(一旦网络状态发生改变, 就会发出通知kReachabilityChangedNotification)
    [self.conn startNotifier];
#pragma mark -- 推送
    [self pushinit:launchOptions];
    
    
    return YES;
}
#pragma mark - push
- (void)pushinit:(NSDictionary *)launchOptions{
    [UMessage startWithAppkey:@"589a7a7cf43e484c200021f9" launchOptions:launchOptions httpsenable:YES ];
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
//    [UMessage startWithAppkey:@"your appkey" launchOptions:launchOptions];
    
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
    
    /*
     TAG:
     1. 可以为单个tag（NSString）也可以为tag集合（NSArray、NSSet）
     2. 每台设备最多绑定64个tag，超过64个，绑定tag不再成功
     3. 单个tag最大允许长度50字节，编码UTF-8，超过长度自动截取
     **/
    //将标签“男”绑定至该设备: tag参数既可以是NSString的单个tag，也可以是NSArray,NSSet的tag集合哦！
    [UMessage addTag:@"男"
            response:^(id responseObject, NSInteger remain, NSError *error) {
                //add your codes
            }];
//    //删除tag：
//    [UMessage removeTag:@"男"
//               response:^(id responseObject, NSInteger remain, NSError *error) {
//                   //add your codes
//               }];
//    //获取tag列表
//    [UMessage getTags:^(NSSet *responseTags, NSInteger remain, NSError *error) {
//        //add your codes
//    }];
//    //重置tag列表
//    [UMessage removeAllTags:^(id responseObject, NSInteger remain, NSError *error) {
//        
//    }];

    /*
     使用别名
     1. type的类型已经默认枚举好平台类型，在UMessage.h最上侧，形如:kUMessageAliasTypeSina
     2. type的类型如果默认的满足不了需求，可以自定义这个字段
     设置别名(setAlias)
     **/
    // 将新浪微博的某用户绑定至设备，老的绑定的设备还在
    [UMessage addAlias:@"test@test.com" type:kUMessageAliasTypeSina response:^(id responseObject, NSError *error) {
    }];
//    //将新浪微博的某用户绑定至设备,覆盖老的，一一对应
//    [UMessage setAlias:@"test@test.com" type:kUMessageAliasTypeSina response:^(id responseObject, NSError *error) {
//    }];
//    //将新浪微博的别名绑定删除
//    [UMessage removeAlias:@"test@test.com" type:kUMessageAliasTypeSina response:^(id responseObject, NSError *error) {
//    }];
//    
}
//（1.2.7开始可以不用设置）
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //[UMessage registerDeviceToken:deviceToken];
    //如何获取设备的 DeviceToken
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);

}
//TODO: 接受通知
//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
    
}
//iOS10以前接收的方法
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    //这个方法用来做action点击的统计
    [UMessage sendClickReportForRemoteNotification:userInfo];
    //下面写identifier对各个交互式的按钮进行业务处理

}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        if([response.actionIdentifier isEqualToString:@"*****你定义的action id****"])
        {
            
        }else
        {
            
            
        }
        //这个方法用来做action点击的统计
        [UMessage sendClickReportForRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
    
}
//TODO: 如需关闭推送，请使用[UMessage unregisterForRemoteNotifications](iOS10此功能存在系统bug,建议不要在iOS10使用。iOS10出现的bug会导致关闭推送后无法打开推送。)

#pragma mark -


#pragma mark - bugly
- (void)setupBugly {
    // Get the default config
    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    // Open the debug mode to print the sdk log message.
    // Default value is NO, please DISABLE it in your RELEASE version.
#if DEBUG
    config.debugMode = YES;
#endif
    
    // Open the customized log record and report, BuglyLogLevelWarn will report Warn, Error log message.
    // Default value is BuglyLogLevelSilent that means DISABLE it.
    // You could change the value according to you need.
    config.reportLogLevel = BuglyLogLevelWarn;
    
    // Open the STUCK scene data in MAIN thread record and report.
    // Default value is NO
    config.blockMonitorEnable = YES;
    
    // Set the STUCK THRESHOLD time, when STUCK time > THRESHOLD it will record an event and report data when the app launched next time.
    // Default value is 3.5 second.
    config.blockMonitorTimeout = 1.5;
    
    // Set the app channel to deployment
    config.channel = @"AppStore";
    
    //    config.version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] ;
    
    config.delegate = self;
    //    //TODO: 从网络获取 js , 关闭热更新 debug 就会从网上获取 js 否则本地获取
    //    //用于本地调试脚本使用，发布前请务必关闭
    //    config.hotfixDebugMode = NO;
    // NOTE:Required
    // Start the Bugly sdk with APP_ID and your config
    [Bugly startWithAppId:nil
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
    // Set the customizd tag thats config in your APP registerd on the  bugly.qq.com
    // [Bugly setTag:1799];
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
    
    //    BLYLogError(@"BLYLogError %@", FLAGESTR);
    //    BLYLogWarn(@"BLYLogWarn %@", FLAGESTR);
    ////    BLYLogInfo(@"BLYLogInfo %@", FLAGESTR);
    //    BLYLogv(BuglyLogLevelWarn, @"BLYLogv: BuglyDemoFlag", NULL);
    ////    BLYLogDebug(@" BLYLogDebug %@", FLAGESTR);
    //    BLYLog(BuglyLogLevelError, @"BLYLog : %@", FLAGESTR);
    ////    BLYLogVerbose(@"BLYLogVerbose %@", FLAGESTR);
    
    
    //
    //    BLYLogError(@"BLYLogError %@", FLAGESTR);
    //    BLYLogWarn(@"BLYLogWarn %@", FLAGESTR);
    //    BLYLogv(BuglyLogLevelWarn, @"BLYLogv: BuglyDemoFlag", NULL);
    
    //    BLYLog(BuglyLogLevelError, @"user_id : %@", [SaveInfo shareSaveInfo].user_id);
    
    // NOTE: This is only TEST code for BuglyLog , please UNCOMMENT it in your code.
    //        [self performSelectorInBackground:@selector(testLogOnBackground) withObject:nil];
}

#pragma mark  BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    return @"This is an attachment";
}
#pragma mark -

#pragma mark - 网络监控
// 处理网络状态改变
- (void)networkStateChange
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
        internetActive = YES;
        //下载皮肤
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        internetActive = YES;
        //下载皮肤
        
    } else { // 没有网络
        NSLog(@"没有网络");
        internetActive = NO;
    }
}
- (BOOL)isExistNetwork {
    return internetActive;
}

-(NetworkStatus)getNetworkStatus
{
    return hostReachState;
}
#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
