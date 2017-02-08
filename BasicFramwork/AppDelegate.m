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
#import <BuglyHotfix/Bugly.h>

@interface AppDelegate ()<BuglyDelegate>
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
    SWIZZ_IT_WITH_TAG(LOGTAG);
    // 监听网络状态改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    
    // 创建Reachability
    self.conn = [Reachability reachabilityForInternetConnection];
    self.conn = [Reachability reachabilityWithHostName:@"apilct.lecuntao.com"];
    // 开始监控网络(一旦网络状态发生改变, 就会发出通知kReachabilityChangedNotification)
    [self.conn startNotifier];
    
    
    
    return YES;
}

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
    
    config.version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] ;
    
    config.delegate = self;
    //TODO: 从网络获取 js , 关闭热更新 debug 就会从网上获取 js 否则本地获取
    //用于本地调试脚本使用，发布前请务必关闭
    config.hotfixDebugMode = NO;
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
    
    BLYLog(BuglyLogLevelError, @"user_id : %@", [SaveInfo shareSaveInfo].user_id);
    
    // NOTE: This is only TEST code for BuglyLog , please UNCOMMENT it in your code.
    //        [self performSelectorInBackground:@selector(testLogOnBackground) withObject:nil];
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    return @"This is an attachment";
}


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


#pragma 网络监控
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
@end
