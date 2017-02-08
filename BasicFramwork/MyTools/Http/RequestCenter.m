//
//  RequestCenter.m
//  LXY
//
//  Created by guohui on 16/3/9.
//  Copyright © 2016年 guohui. All rights reserved.
//

#import "RequestCenter.h"
#import "Encryption.h"
#import "SaveInfo.h"
#import "GHControl.h"
#define MEMBER_PHOTO @"member_photo"
#define MD5KEY @"mk"
#define NONETMESSAGE @"网络连接失败,请稍后再试!!"
// mk   加密的数据
@implementation RequestCenter
+ (RequestCenter *)shareRequestCenter{
    @synchronized(self) { //创建一个互斥锁，保证此时没有其它线程对self对象进行修改。这个是objective-c的一个锁定令牌，防止self对象在同一时间内被其它线程访问，起到线程的保护作用。 一般在公用变量的时候使用，如单例模式或者操作类的static变量中使用。
        static RequestCenter *_self ; //局部变量在代码块结束后将不会回收，下次使用保持上次使用后的值；static用在方法与全局变量，表示该方法与全局变量只在本文件中有效，外部无法使用extern引用该全局变量或方法。
        if (!_self) {
            
            _self = [[RequestCenter alloc]init];
        }
        return _self ;
    }
}

#pragma mark - get
-(void)sendRequestGetUrl:(NSMutableString *)myUrl andDic:(NSDictionary *)info_dic setSuccessBlock:(void (^)(NSDictionary *))success_block setFailBlock:(void (^)(NSString *))fail_block{
    HUDSelfStart(@"正在上传数据...");
    NETWORKVIEW(YES);

    AFHTTPSessionManager *session_manager = [AFHTTPSessionManager manager];
    NSLog(@"\n%@\n%@\n",myUrl,info_dic);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithDictionary:info_dic];
    
    [postDic setValue:@"ios" forKey:@"client"];
    [postDic setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"version"];
     if ([[SaveInfo shareSaveInfo] key].length > 0) {
        [postDic setValue:[[SaveInfo shareSaveInfo] key] forKey:@"key"];
    }else{
        [postDic setValue:@"" forKey:@"key"];
    }
    //TODO: 设置格式
    {
    [session_manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    session_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    }
    session_manager.requestSerializer.timeoutInterval = 8 ; // 默认60秒超时
    NSLog(@"\ngeturl:%@\n\n",STR_a_ADD_b_(HTTPSERVICE, myUrl));
    [self poingLog:STR_a_ADD_b_(HTTPSERVICE, myUrl) postDic:postDic];
    [session_manager GET:STR_a_ADD_b_(HTTPSERVICE, myUrl) parameters:postDic progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"下载进度:%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NETWORKVIEW(NO);
        HUDSelfEnd;
        if (responseObject) {
            success_block(responseObject);
        }else{
            HUDNormal(@"服务器异常");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        HUDSelfEnd;
        NETWORKVIEW(NO);
        HUDNormal(@"请求失败");
        if (error.code == -1009) {
            HUDNormal(NONETMESSAGE);
        }
        if (fail_block) {
            fail_block([error description]);
        }
        
    }];
    
}
- (void)sendRequestPostUrl:(NSString *)myUrl andDic:(NSDictionary *)info_dic setSuccessBlock:(void (^)(NSDictionary *))success_block setFailBlock:(void (^)(NSString *))fail_block{
    HUDSelfStart(@"正在请求数据...");
    NETWORKVIEW(YES);
    
    AFHTTPSessionManager *session_manager = [AFHTTPSessionManager manager];
    session_manager.requestSerializer.timeoutInterval = 8 ;//
    //TODO: 设置格式
    {
        session_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    }
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithDictionary:info_dic];
    [postDic setValue:@"ios" forKey:@"client"];
    [postDic setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"version"];
    if ([[SaveInfo shareSaveInfo] key].length > 0) {
        [postDic setValue:[[SaveInfo shareSaveInfo] key] forKey:@"key"];
    }else{
        [postDic setValue:@"" forKey:@"key"];
    }
    NSLog(@"postUrl-------:\n%@ \npostDic:\n%@",STR_a_ADD_b_(HTTPSERVICE, myUrl),postDic);
    [self poingLog:STR_a_ADD_b_(HTTPSERVICE, myUrl) postDic:postDic];
    
    [session_manager POST:STR_a_ADD_b_(HTTPSERVICE, myUrl) parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        GLOG(@"Post_uploadProgress", uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLOG(@"responseObject", responseObject);
        GLOG(@"信息", [responseObject objectForKey:@"msg"]);
        
        NETWORKVIEW(NO);
        HUDSelfEnd;
 
        if (responseObject) {
            success_block(responseObject);
        }else{
            HUDNormal(@"服务器异常");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLOG(@"error", error);
        NETWORKVIEW(NO);
        HUDSelfEnd ;
        if (error.code == -1009) {
            HUDNormal(NONETMESSAGE);
        }
        if (fail_block) {
            fail_block([error description]);
        }
    }];

}
- (void)sendRequestNohudPostUrl:(NSString *)myUrl andDic:(NSDictionary *)info_dic setSuccessBlock:(void (^)(NSDictionary *))success_block setFailBlock:(void (^)(NSString *))fail_block{
    NETWORKVIEW(YES);
    
    AFHTTPSessionManager *session_manager = [AFHTTPSessionManager manager];
    session_manager.requestSerializer.timeoutInterval = 8 ;//
    //TODO: 设置格式
    {
        session_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    }
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithDictionary:info_dic];
    [postDic setValue:@"ios" forKey:@"client"];
    [postDic setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"version"];
     if ([[SaveInfo shareSaveInfo] key].length > 0) {
        [postDic setValue:[[SaveInfo shareSaveInfo] key] forKey:@"key"];
    }else{
        [postDic setValue:@"" forKey:@"key"];
    }
    
    NSLog(@"postUrl-------:\n%@ \npostDic:\n%@",STR_a_ADD_b_(HTTPSERVICE, myUrl),postDic);
    [self poingLog:STR_a_ADD_b_(HTTPSERVICE, myUrl) postDic:postDic];

    
    [session_manager POST:STR_a_ADD_b_(HTTPSERVICE, myUrl) parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        GLOG(@"Post_uploadProgress", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLOG(@"responseObject", responseObject);
        GLOG(@"信息", [responseObject objectForKey:@"msg"]);
        
        NETWORKVIEW(NO);
        
        if (responseObject) {
            success_block(responseObject);
        }else{
            HUDNormal(@"服务器异常");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLOG(@"error", error);
        NETWORKVIEW(NO);

//        NSLog(@"error.userInfo%@",error.userInfo[@"NSLocalizedDescription"]);
        if (error.code == -1009) {
            HUDNormal(NONETMESSAGE);
        }
        if (fail_block) {
            fail_block([error description]);
        }
    }];
    
}
- (NSString *)poingLog:(NSString *)posturl postDic:(NSDictionary *)posDic{
    NSMutableString *mt_url_log = [NSMutableString stringWithString:posturl];
    for (NSString *keystr in [posDic allKeys]) {
        [mt_url_log appendFormat:@"&%@=%@",keystr,posDic[keystr]];
    }
    
    NSLog(@" \n**********\n***********\n*********\n***********\n**********\n*********\n转化为 post请求:\n\n%@\n\n**********\n***********\n*********\n***********\n**********\n*********\n\n",mt_url_log);
    return mt_url_log ;
}

- (void)requestBackStrPostUrl:(NSString *)myUrl andDic:(NSDictionary *)info_dic setSuccessBlock:(void (^)(NSString *))success_block setFailBlock:(void (^)(NSString *))fail_block{
    HUDSelfStart(@"正在请求数据...");
    NETWORKVIEW(YES);
    AFHTTPSessionManager *session_manager = [AFHTTPSessionManager manager];
    session_manager.requestSerializer.timeoutInterval = 8 ;//
    //TODO: 设置格式
    //    {
    //        [session_manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    session_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    //    }
    session_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    session_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithDictionary:info_dic];
    [postDic setValue:@"ios" forKey:@"client"];
    [postDic setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"version"];
     if ([[SaveInfo shareSaveInfo] key].length > 0) {
        [postDic setValue:[[SaveInfo shareSaveInfo] key] forKey:@"key"];
    }else{
        [postDic setValue:@"" forKey:@"key"];
    }

    NSLog(@"postUrl-------:\n%@ \npostDic:\n%@",STR_a_ADD_b_(HTTPSERVICE, myUrl),postDic);
    
    [self poingLog:STR_a_ADD_b_(HTTPSERVICE, myUrl) postDic:postDic];
    
    [session_manager POST:STR_a_ADD_b_(HTTPSERVICE, myUrl) parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        GLOG(@"Post_uploadProgress", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLOG(@"responseObject", responseObject);
        
      
        NETWORKVIEW(NO);
        HUDSelfEnd;
        
        if (responseObject) {
            NSData *doubi = responseObject;
            NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
            GLOG(@"shabi:\n\n\n\n", shabi);
            success_block(shabi);
        }else{
            HUDNormal(@"服务器异常");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLOG(@"error", error);
        NETWORKVIEW(NO);
        HUDSelfEnd ;
        HUDNormal(@"请求失败");
        if (error.code == -1009) {
            HUDNormal(NONETMESSAGE);
        }
        if (fail_block) {
            fail_block([error description]);
        }
    }];
    
}

- (NSString *)geturlstr:(NSString *)myurl andpostdic:(NSDictionary *)postdic{
    NSMutableString *mtpost_url = [NSMutableString stringWithCapacity:0];
    if ([[SaveInfo shareSaveInfo] key].length > 0) {
        [mtpost_url appendFormat:@"%@&key=%@",STR_a_ADD_b_(HTTPSERVICE, myurl),[[SaveInfo shareSaveInfo] key]];
    }else{
        [mtpost_url appendFormat:@"%@&key=%@",STR_a_ADD_b_(HTTPSERVICE, myurl),@""];
    }
    NSString *urlstr = [self poingLog:mtpost_url postDic:postdic];
    return urlstr ;
}

- (void)sendRequestImageUrl:(NSString *)myUrl infoDic:(NSDictionary *)info_dict andImageDic:(NSDictionary *)imageDic setSuccessBlock:(void (^)(NSDictionary *))success_block setFailBlock:(void (^)(NSString *))fail_block{
    NETWORKVIEW(YES);
    HUDSelfStart(@"图片正在上传 ...");
    GLOG(@"url", myUrl);
    GLOG(@"dic", info_dict);
    GLOG(@"imageDic", imageDic);
    
    UIImage *image = [imageDic allValues].firstObject;
    image = [self imageWithImage:image scaledToSize:CGSizeMake(120, 120)];
    NSData *myDate = UIImageJPEGRepresentation(image, 1);
    AFHTTPSessionManager *session_manager = [AFHTTPSessionManager manager];
    session_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    
    [session_manager POST:STR_a_ADD_b_(HTTPSERVICE, myUrl) parameters:info_dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /**
         *  appendPartWithFileData: 图片的data
                              name: 上传图片的名字
                          fileName: 图片的后缀名
                          mimeType: 上传图片类型
         */
        GLOG(@"formData", formData);
        [formData appendPartWithFileData:myDate name:imageDic.allKeys.firstObject fileName:@".png" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        GLOG(@"uploadProgress", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLOG(@"responseObject", responseObject);
        NETWORKVIEW(NO);
        HUDSelfEnd;
        if (responseObject) {
            
            success_block(responseObject);
        }else{
            HUDNormal(@"服务器异常");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLOG(@"error", error);
        NETWORKVIEW(NO);
        HUDSelfEnd;
        HUDNormal(@"上传失败");
        if (error.code == -1009) {
            HUDNormal(NONETMESSAGE);
        }
        if (fail_block) {
            fail_block([error description]);
        }
    }];
}

- (void)sendRequestImageUrl:(NSString *)myUrl andImage:(UIImage *)image setSuccessBlock:(void (^)(NSDictionary *resultDic))success_block setFailBlock:(void (^)(NSString *))fail_block{
    NETWORKVIEW(YES);
    HUDSelfStart(@"图片正在上传 ...");
    GLOG(@"url", myUrl);
    GLOG(@"image", image);
    

    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [postDic setValue:@"ios" forKey:@"client"];
    [postDic setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"version"];
     if ([[SaveInfo shareSaveInfo] key].length > 0) {
        [postDic setValue:[[SaveInfo shareSaveInfo] key] forKey:@"key"];
    }else{
        [postDic setValue:@"" forKey:@"key"];
    }
    
    NSLog(@"postUrl-------:\n%@ \npostDic:\n%@",STR_a_ADD_b_(HTTPSERVICE, myUrl),postDic);
    
    [self poingLog:STR_a_ADD_b_(HTTPSERVICE, myUrl) postDic:postDic];
    
    image = [self imageWithImage:image scaledToSize:CGSizeMake(120, 120)];
    NSData *myDate = UIImageJPEGRepresentation(image, 1);
    AFHTTPSessionManager *session_manager = [AFHTTPSessionManager manager];
    session_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    [session_manager POST:STR_a_ADD_b_(HTTPSERVICE, myUrl) parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /**
         *  appendPartWithFileData: 图片的data
         name: 上传图片的名字
         fileName: 图片的后缀名
         mimeType: 上传图片类型
         */
        GLOG(@"formData", formData);
        [formData appendPartWithFileData:myDate name:MEMBER_PHOTO fileName:@".png" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        GLOG(@"uploadProgress", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLOG(@"responseObject", responseObject);
        GLOG(@"信息", [responseObject objectForKey:@"msg"]);
        NETWORKVIEW(NO);
        HUDSelfEnd;
        if (responseObject) {
            
            success_block(responseObject);
        }else{
            HUDNormal(@"服务器异常");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLOG(@"error", error);
        NETWORKVIEW(NO);
        HUDSelfEnd;
        HUDNormal(@"上传失败");
        if (fail_block) {
            fail_block([error description]);
        }
    }];
}


#pragma mark -  对图片尺寸进行压缩
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
