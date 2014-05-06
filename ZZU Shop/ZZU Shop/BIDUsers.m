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
            self.secretKey = userInfo[@"secretKey"];
            
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
    //创建请求API的地址
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
    //创建请求API的地址
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
    //创建请求API的地址
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
    //创建请求API的地址
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

- (void)getPasswordBackByQuestion
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *getPassword_QIP = IP;
    NSString *getPassword_QAPIURL = @":8080/zzuShop/interfaceJson/jsonForgotPasswordAction_backPasswordByQuestion.action?";
    //创建含参数的url请求
    NSString *getPassword_QURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&q_id=%ld&answer=%@", getPassword_QIP, getPassword_QAPIURL, self.userName, (long)self.q_id, self.answer];
    //将带有汉字的url转码成utf－8编码
    getPassword_QURL = [getPassword_QURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *getPassword_QRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:getPassword_QURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:getPassword_QRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getPasswordBackByEmail
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *getPassword_EIP = IP;
    NSString *getPassword_EAPIURL = @":8080/zzuShop/interfaceJson/jsonForgotPasswordAction_backPasswordByEmail.action?";
    //创建含参数的url请求
    NSString *getPassword_EURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&email=%@", getPassword_EIP, getPassword_EAPIURL, self.userName, self.email];
    //将带有汉字的url转码成utf－8编码
    getPassword_EURL = [getPassword_EURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *getPassword_ERequest = [NSURLRequest requestWithURL:[NSURL URLWithString:getPassword_EURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:getPassword_ERequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)changePassword
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *changePasswordIP = IP;
    NSString *changePasswordAPIURL = @":8080/zzuShop/interfaceJson/jsonUpdatePasswordAction_updatePassword.action?";
    //创建含参数的url请求
    NSString *changePasswordURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&newPassword=%@&oldPassword=%@", changePasswordIP, changePasswordAPIURL, self.userName, self.theNewPassword, self.password];
    //将带有汉字的url转码成utf－8编码
    changePasswordURL = [changePasswordURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *changePasswordRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:changePasswordURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:changePasswordRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)changeNickName
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *changeNickNameIP = IP;
    NSString *changeNickNameAPIURL = @":8080/zzuShop/interfaceJson/jsonUpdateNickNameAction_updateNickName.action?";
    //创建含参数的url请求
    NSString *changeNickNameURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&nickName=%@", changeNickNameIP, changeNickNameAPIURL, self.userName, self.secretKey, self.nickName];
    //将带有汉字的url转码成utf－8编码
    changeNickNameURL = [changeNickNameURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *changeNickNameRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:changeNickNameURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:changeNickNameRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)changePhoneNumber
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *changePhoneNumberIP = IP;
    NSString *changePhoneNumberAPIURL = @":8080/zzuShop/interfaceJson/jsonUpdatePhoneNumberAction_updatePhoneNumber.action?";
    //创建含参数的url请求
    NSString *changePhoneNumberURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&phoneNumber=%@", changePhoneNumberIP, changePhoneNumberAPIURL, self.userName, self.secretKey, self.phoneNumber];
    //将带有汉字的url转码成utf－8编码
    changePhoneNumberURL = [changePhoneNumberURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *changePhoneNumberRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:changePhoneNumberURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:changePhoneNumberRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)changeEmail
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *changeEmailIP = IP;
    NSString *changeEmailAPIURL = @":8080/zzuShop/interfaceJson/jsonUpdateEmailAction_updateEmail.action?";
    //创建含参数的url请求
    NSString *changeEmailURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&email=%@", changeEmailIP, changeEmailAPIURL, self.userName, self.secretKey, self.email];
    //将带有汉字的url转码成utf－8编码
    changeEmailURL = [changeEmailURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *changeEmailRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:changeEmailURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:changeEmailRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getPersonalRecList
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *personalListIP = IP;
    NSString *personalListAPIURL = @":8080/zzuShop/interfaceJson/jsonGetPersonalizedProductListAction_getPersonalizedProductList.action?";
    //创建含参数的url请求
    NSString *personalListURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@", personalListIP, personalListAPIURL, self.userName, self.secretKey];
    //将带有汉字的url转码成utf－8编码
    personalListURL = [personalListURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *personalListRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:personalListURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:personalListRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getAllList
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *allListIP = IP;
    NSString *allListAPIURL = @":8080/zzuShop/interfaceJson/jsonGetOrderListAction_getOrderList.action?";
    //创建含参数的url请求
    NSString *allListURL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&page=%ld", allListIP, allListAPIURL, self.userName, self.secretKey, (long)self.listPage];
    //将带有汉字的url转码成utf－8编码
    allListURL = [allListURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *allListRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:allListURL]];
    self.userData = [NSURLConnection sendSynchronousRequest:allListRequest returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

@end
