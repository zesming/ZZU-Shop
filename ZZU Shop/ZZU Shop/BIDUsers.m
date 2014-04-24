//
//  BIDUsers.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-22.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDUsers.h"
#import "general.h"


@implementation BIDUsers

- (id)init
{
    if (self = [super init]) {
        NSString *url = [NSString stringWithFormat:@"%@%@", filePath, @"userInfo.plist"];
        NSDictionary *userInfo = [[NSDictionary alloc] initWithContentsOfFile:url];
        if (userInfo) {
            self.userName = userInfo[@"studentID"];
            self.password = userInfo[@"password"];
            self.nickName = userInfo[@"nickName"];
            self.email = userInfo[@"email"];
            self.phoneNumber = userInfo[@"phoneNumber"];
            
        }
        return self;
    }
    return self;
}

- (void)loginRequest
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址与AppKey
    NSString *loginIP = IP;
    NSString *loginAPIURL = @":8080/zzuShop/interfaceJson/jsonUserLoginAction_login.action?";
    //创建含参数的url请求
    NSString *loginURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&password=%@", loginIP, loginAPIURL, self.userName, self.password];
    //将带有汉字的url转码成utf－8编码
    loginURL = [loginURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *loginRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:loginURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:loginRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)writeUserInfoToFileWithUserInfo:(NSDictionary *)userInfo
{
    NSString *url = [NSString stringWithFormat:@"%@%@", filePath, @"userInfo.plist"];
    [userInfo writeToFile:url atomically:YES];
}

@end
