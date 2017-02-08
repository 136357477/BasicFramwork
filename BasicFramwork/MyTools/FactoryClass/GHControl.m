//
//  ZCControl.m
//  ControlDemo
//
//  Created by guohui on 14/12/18.
//  Copyright (c) 2014年 guohui. All rights reserved.
//

#import "GHControl.h"
#import "AppDelegate.h"

#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0
@implementation GHControl

//+(void)add_image:(NSString*)pathurl completion:(IMAGE_Completion)completion {
//    if (pathurl == nil) {
//        self->image_return = nil;
//        completion(nil);
//    } else {
//        pathurl = [pathurl
//                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        //获取图片存储在本地的名称
//        NSString* picName = [self resultPicName:pathurl];
//        BOOL ishas = [self isExistPathFile:picName];
//        if (ishas) {
//            UIImage* image_s = [self getPhotoFromName:picName];
//            if (image_s != nil) {
//                self.image_return = image_s;
//                completion(image_s);
//            }
//        } else {
//            if (!YouGu_Wifi_Image) {
//                completion(nil);
//                return;
//            }
//            UIImageFromURL([NSURL URLWithString:pathurl],
//                           ^(UIImage* image) {
//                               if (image != nil) {
//                                   [self setPhotoToPath:image isName:picName];
//                                   completion(image);
//                               }
//                           },
//                           ^(void){
//                           });
//        }
//    }
//}

+ (NSString *)platformString{

    return @"设备号是：";//此类待完善，2015，03，18 周三  郭辉
}
// 设置文字颜色
+ (NSMutableAttributedString *)changelabcolor:(NSString *)labstr changestr:(NSString *)changestr andchangecolor:(UIColor *)changecolor{
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:labstr];
    [abs beginEditing];
    //字体颜色
    NSRange range  = [labstr rangeOfString:changestr];
    [abs addAttribute:NSForegroundColorAttributeName
                value:changecolor
                range:range];
    return abs ;
}
+(NSString *)changeNumPayMoney:(NSString *)payNum{

    NSString *str = nil;
    if ([payNum length]>=5&&[payNum length]<9) {
        double num = [payNum doubleValue]/10000;
        str = [[NSString stringWithFormat:@"%.1lf",num] stringByAppendingString:@"万人付款"];
    }else if ([payNum length]>=9){
        double num = [payNum doubleValue]/100000000;
        str = [[NSString stringWithFormat:@"%.1lf",num] stringByAppendingString:@"亿人付款"];
    }else{
        str = [payNum stringByAppendingString:@"人付款"];;
    }
    return str;
}
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
    
}
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    
    return view ;
    
}
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField ;
    
}
#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
    UITextField*text= [self createTextFieldWithFrame:frame placeholder:placeholder passWord:YESorNO leftImageView:imageView rightImageView:rightImageView Font:font];
    text.background=[UIImage imageNamed:imageName];
    return  text;
    
}
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    return scrollView ;
}
+(UIPageControl*)makePageControlWithFram:(CGRect)frame
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    return pageControl;
}
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider ;
}
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma -mark 判断导航的高度
+(float)isIOS7{
    
    float height;
    if (IOS7) {
        height=64.0;
    }else{
        height=44;
    }
    
    return height;
}
//+(NSString *)platformString{
//    // Gets a string with the device model
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
//    NSDictionary* d = nil;
//    if (d == nil)
//    {
//        d = @{
//              @"iPhone1,1": @"iPhone 2G",
//              @"iPhone1,2": @"iPhone 3G",
//              @"iPhone2,1": @"iPhone 3GS",
//              @"iPhone3,1": @"iPhone 4",
//              @"iPhone3,2": @"iPhone 4",
//              @"iPhone3,3": @"iPhone 4 (CDMA)",
//              @"iPhone4,1": @"iPhone 4S",
//              @"iPhone5,1": @"iPhone 5",
//              @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
//
//              @"iPod1,1": @"iPod Touch (1 Gen)",
//              @"iPod2,1": @"iPod Touch (2 Gen)",
//              @"iPod3,1": @"iPod Touch (3 Gen)",
//              @"iPod4,1": @"iPod Touch (4 Gen)",
//              @"iPod5,1": @"iPod Touch (5 Gen)",
//
//              @"iPad1,1": @"iPad",
//              @"iPad1,2": @"iPad 3G",
//              @"iPad2,1": @"iPad 2 (WiFi)",
//              @"iPad2,2": @"iPad 2",
//              @"iPad2,3": @"iPad 2 (CDMA)",
//              @"iPad2,4": @"iPad 2",
//              @"iPad2,5": @"iPad Mini (WiFi)",
//              @"iPad2,6": @"iPad Mini",
//              @"iPad2,7": @"iPad Mini (GSM+CDMA)",
//              @"iPad3,1": @"iPad 3 (WiFi)",
//              @"iPad3,2": @"iPad 3 (GSM+CDMA)",
//              @"iPad3,3": @"iPad 3",
//              @"iPad3,4": @"iPad 4 (WiFi)",
//              @"iPad3,5": @"iPad 4",
//              @"iPad3,6": @"iPad 4 (GSM+CDMA)",
//
//              @"i386": @"Simulator",
//              @"x86_64": @"Simulator"
//              };
//    }
//    NSString* ret = [d objectForKey: platform];
//
//    if (ret == nil)
//    {
//        return platform;
//    }
//    return ret;
//}

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval
{
    NSTimeInterval seconds = [timeInterval integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height + 5;
}
#pragma mark - 图片 - 
+ (UIImage *)getLocalPngImge:(NSString *)imageName{
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}
+ (UIImage *)getLocalJPGImage:(NSString *)ImageName{
    NSString *path = [[NSBundle mainBundle] pathForResource:ImageName ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:path];
}


// 返回一个整数字符串加1后的新字符串
+ (NSString *)addOneByIntegerString:(NSString *)integerString
{
    NSInteger integer = [integerString integerValue];
    return [NSString stringWithFormat:@"%ld",(long)(integer+1)];
}

#pragma mark - 主线程延迟处理
+ (void)performBlockOnMainThread:(void (^)())block withDelaySeconds:(float)delayInSeconds {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark - 分线程延迟处理
+ (void)performBlockOnGlobalThread:(void (^)())block withDelaySeconds:(float)delayInSeconds {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(0, 0), block);
}
#pragma mark - 手机号判断
+ (BOOL)lengalPhoneNumber:(NSString *)numStr {
    /*
     * 移动: 2G号段(GSM网络)有139,138,137,136,135,134,159,158,152,151,150,
     * 3G号段(TD-SCDMA网络)有157,182,183,188,187 147是移动TD上网卡专用号段. 联通:
     * 2G号段(GSM网络)有130,131,132,155,156 3G号段(WCDMA网络)有186,185 电信:
     * 2G号段(CDMA网络)有133,153 3G号段(CDMA网络)有189,180
     */
    NSString *YD = @"^[1]{1}(([3]{1}[4-9]{1})|([5]{1}[012789]{1})|([8]{1}[2378]{"
    @"1})|([4]{1}[7]{1}))[0-9]{8}$";
    NSString *LT = @"^[1]{1}(([3]{1}[0-2]{1})|([4]{1}[5]{1})|([5]{1}[56]{1})|([8]"
    @"{1}[56]{1}))[0-9]{8}$";
    NSString *DX =
    @"^[1]{1}(([3]{1}[3]{1})|([5]{1}[3]{1})|([8]{1}[09]{1}))[0-9]{8}$";
    // 判断手机号码是否是11位
    if ([numStr length] == 11) {
        // 判断手机号码是否符合中国移动的号码规则
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"SELF MATCHES %@", YD];
        if ([predicate evaluateWithObject:numStr])
            return YES;
        // 判断手机号码是否符合中国联通的号码规则
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", LT];
        if ([predicate evaluateWithObject:numStr])
            return YES;
        // 判断手机号码是否符合中国电信的号码规则
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", DX];
        if ([predicate evaluateWithObject:numStr])
            return YES;
    }
    return NO;
}

#pragma mark ---  姓名判断
+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *identityCardPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    if ([identityCardPredicate evaluateWithObject:identityCard]) {
        return YES;
    }
    
    return NO;
}

#pragma mark color 变image
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//隐藏空白单元格
+(void)setExtraCellLineHidden:(UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
//地址信息清空
+(void)defultsForEmpty{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"" forKey:@"province_name"];
    [defaults setObject:@"" forKey:@"province_id"];
    
    [defaults setObject:@"" forKey:@"city_name"];
    [defaults setObject:@"" forKey:@"city_id"];
    
    [defaults setObject:@"" forKey:@"county_name"];
    [defaults setObject:@"" forKey:@"county_id"];
    
    [defaults setObject:@"" forKey:@"town_name"];
    [defaults setObject:@"" forKey:@"town_id"];
    
    [defaults setObject:@"" forKey:@"village_name"];
    [defaults setObject:@"" forKey:@"village_id"];
}
//时间戳转换时间
+(NSString *)stringFromDateWithString:(NSString *)dateString andDataFormat:(NSString *)dataFormat
{
    NSString*str=dateString;//时间戳
    
    NSTimeInterval time=[str doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:dataFormat];//yyyy-MM-dd HH:mm:ss
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}
//拨打电话
+(UIWebView *)makeTelPhoneNum{

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000880692"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    return callWebview;

}
//时间戳转换时间
+(NSString *)stringFromDateWithString:(NSString *)dateString
{
    NSString*str=dateString;//时间戳
    
    NSTimeInterval time=[str doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}
//#16进制转10进制
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+ (NSArray *)getAllFileNames:(NSString *)dirName
{
    // 获得此程序的沙盒路径
    NSString *fileDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",dirName]];
//    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    // 获取Documents路径
//    // [patchs objectAtIndex:0]
//    NSString *documentsDirectory = [patchs objectAtIndex:0];
//    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:@"%@",dirName];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    
    return files;
}
#pragma mark - 系统数据
+ (BOOL)isExistNetwork {
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appDelegate isExistNetwork];
//    return YES ;
}
+(BOOL)isNetworkWIFI
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return  ([appDelegate getNetworkStatus]==ReachableViaWiFi) ;
//    return YES ;
}

@end
