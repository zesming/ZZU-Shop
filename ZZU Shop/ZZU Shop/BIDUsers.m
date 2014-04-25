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

- (void)checkStudentIDAndRealName
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址与AppKey
    NSString *checkInfoIP = IP;
    NSString *checkInfoAPIURL = @":8080/zzuShop/interfaceJson/jsonVerifyRegistAction_verifyRegist.action?";
    //创建含参数的url请求
    NSString *checkInfoURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&name=%@", checkInfoIP, checkInfoAPIURL, self.userName, self.realName];
    //将带有汉字的url转码成utf－8编码
    checkInfoURL = [checkInfoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *checkInfoRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:checkInfoURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:checkInfoRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getQuestionsList{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址与AppKey
    NSString *getQuestionsListIP = IP;
    NSString *getQuestionsListAPIURL = @":8080/zzuShop/interfaceJson/jsonGetQuestionsListAction_getQuestionsList.action";
    //创建含参数的url请求
    NSString *getQuestionsListURL = [NSString stringWithFormat:@"http://%@%@", getQuestionsListIP, getQuestionsListAPIURL];
    //将带有汉字的url转码成utf－8编码
    getQuestionsListURL = [getQuestionsListURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *getQuestionsListRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:getQuestionsListURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:getQuestionsListRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)registerNewUser
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址与AppKey
    NSString *registerIP = IP;
    NSString *registerAPIURL = @":8080/zzuShop/interfaceJson/jsonUserRegistAction_regist.action?";
    //创建含参数的url请求
    NSString *registerURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&password=%@&name=%@&nickName=%@&email=%@&q_id=%ld&answer=%@&phoneNumber=%@", registerIP, registerAPIURL, self.userName, self.password, self.realName, self.nickName, self.email, (long)self.q_id, self.answer, self.phoneNumber];
    //将带有汉字的url转码成utf－8编码
    registerURL = [registerURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *registerRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:registerURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:registerRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

@end
