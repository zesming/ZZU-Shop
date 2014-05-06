//
//  BIDImageDownload.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDImageDownload.h"
#import "general.h"

@implementation BIDImageDownload

- (void)imageDownload
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //使用带有参数的url向服务器发出请求
    NSURLRequest *personalListRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.requestData = [NSURLConnection sendSynchronousRequest:personalListRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

@end
