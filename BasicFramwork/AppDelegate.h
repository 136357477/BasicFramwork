//
//  AppDelegate.h
//  BasicFramwork
//
//  Created by guohui on 2017/1/19.
//  Copyright © 2017年 guohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
///有无网络存在
- (BOOL)isExistNetwork;
///判断网络的状态类型
-(NetworkStatus)getNetworkStatus;

@end

