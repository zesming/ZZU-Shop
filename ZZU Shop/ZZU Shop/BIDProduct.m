//
//  BIDProduct.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDProduct.h"
#import "general.h"
#import "BIDUsers.h"

@implementation BIDProduct

- (void)getOneProductInfo
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonGetOneProductInfoAction_getOneProductInfo.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@p_id=%ld", ip, APIURL, (long)self.p_id];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)productRate
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonReviewsProductAction_reviewsProduct.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&p_id=%ld&pr_score=%ld&pr_content=%@", ip, APIURL, userInfo.userName, userInfo.secretKey, (long)self.p_id, (long)self.pr_score, self.pr_content];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getRecProductList
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonGetRecommendProductListAction_getRecommendProductList.action";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@", ip, APIURL];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getSearchResult
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonGetSearchListAction_getSearchList.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@keyWord=%@&page=%ld", ip, APIURL, self.keyWord, (long)self.page];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)addOneInShoppingCart
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonAddOneShoppingCartAction_addOneShoppingCart.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&p_id=%ld&pnum=%ld", ip, APIURL, userInfo.userName, userInfo.secretKey, (long)self.p_id, (long)self.pnum];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getShoppingCart
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonGetShoppingCartListAction_getShoppingCartList.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&page=%ld", ip, APIURL, userInfo.userName, userInfo.secretKey, (long)self.page];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)changeShoppingCartNumber
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonUpdateShoppingCartNumberAction_updateNumber.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&cart_id=%ld&pnum=%ld", ip, APIURL, userInfo.userName, userInfo.secretKey, (long)self.cart_id, (long)self.pnum];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)removeOneShoppingCart
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonDeleteOneShoppingCartAction_deleteOneShoppingCart.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&cart_id=%ld", ip, APIURL, userInfo.userName, userInfo.secretKey, (long)self.cart_id];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)addOneOrder
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonAddOneOrderAction_addOneOrder.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&cart_id=%ld", ip, APIURL, userInfo.userName, userInfo.secretKey, (long)self.cart_id];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getRateList
{
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonProductReviewsListAction_getProductReviewsList.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@p_id=%ld&page=%ld", ip, APIURL, (long)self.p_id, (long)self.page];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)getOrderDetail
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonGetOneOrderAction_getOneOrder.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&orderNumber=%@", ip, APIURL, userInfo.userName, userInfo.secretKey, self.orderNumber];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

- (void)cancleOrder
{
    BIDUsers *userInfo = [BIDUsers new];
    NSError *error;
    //创建网络读取指示器
    UIApplication *app = [UIApplication sharedApplication];
    //在进行网络读取的时候开启指示
    app.networkActivityIndicatorVisible = YES;
    //创建请求API的地址
    NSString *ip = IP;
    NSString *APIURL = @":8080/zzuShop/interfaceJson/jsonDeleteOneOrderAction_deleteOneOrder.action?";
    //创建含参数的url请求
    NSString *URL = [NSString stringWithFormat:@"http://%@%@studentID=%@&secretKey=%@&orderNumber=%@", ip, APIURL, userInfo.userName, userInfo.secretKey, self.orderNumber];
    //将带有汉字的url转码成utf－8编码
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //使用带有参数的url向服务器发出请求
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    self.requestData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:&error];
    self.requestError = error;
    app.networkActivityIndicatorVisible = NO;
}

@end
