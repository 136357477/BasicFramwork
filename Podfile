# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
#pod install --verbose --no-repo-update  不更新本地库
#pod update --verbose --no-repo-update
target 'BasicFramwork' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for BasicFramwork
  pod 'AFNetworking' # 网络请求
  pod 'MJRefresh' #tableview collectionView 上拉刷新,下拉加载更多
  pod 'MBProgressHUD' #提示框
  pod 'SDWebImage' #图片加载
  pod 'UITableView+FDTemplateLayoutCell' #FDTemplateLayoutCell Frame 布局实践 https://skyline75489.github.io/post/2015-12-26_uitableview-fdtemplatecell-dynamic-frame.html
  pod 'UIViewController+Swizzled'  #进入 class 提示进入哪个类
  pod 'UILabel+ContentSize' #自动计算 lab 的高度
  pod 'UMengAnalytics' #友盟统计
#  pod 'Bugly' #bugly 实现统计详细崩溃日志
  pod 'BuglyHotfix' #集成了bugly 热更新 实现统计详细崩溃日志
  pod 'JSPatch/Extensions' #实现调用 js ,
  pod 'FDFullscreenPopGesture' #自动侧或返回
  pod 'XHLaunchAd' #第三方 广告图片加载
  pod 'Reachability' #网络监控  与 AF 耦合
  pod 'SDCycleScrollView' #轮播图
  pod 'JHChart' #表格第三方库 包含表格,散点饼图等
  pod 'WebViewJavascriptBridge' #原生 与 web 交互
  
  target 'BasicFramworkTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BasicFramworkUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
