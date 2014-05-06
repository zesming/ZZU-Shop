//
//  BIDPayTableViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDPayTableViewController.h"

@interface BIDPayTableViewController ()
{
    NSInteger successCount;
    NSInteger failCount;
}

@end

@implementation BIDPayTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单确认";
    self.totalPriceLabel.text = self.totalPriceStr;
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText =@"正在处理，请稍候...";
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    [self.view addSubview:hud];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)confirmOrder
{
    self.addOrder = [BIDProduct new];
    successCount = 0;
    failCount = 0;
    [hud showAnimated:YES whileExecutingBlock:^{
        for (NSInteger i = 0; i < self.productList.count; i ++){
            self.addOrder.cart_id = [self.productList[i] integerValue];
            [self.addOrder addOneOrder];
            if (!self.addOrder.requestError) {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.addOrder.requestData options:NSJSONReadingMutableLeaves error:nil];
                NSInteger resultCode = [resultDic[@"resultcode"] intValue];
                if (resultCode == 200){
                    successCount ++;
                }else{
                    failCount ++;
                }
            }else{
                self.error = self.addOrder.requestError;
                break;
            }
        }
    }onQueue:dispatch_get_global_queue(0,0) completionBlock:^{
        if (!self.error) {
            if (successCount == self.productList.count) {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"所有订单支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                [self.navigationController popViewControllerAnimated:YES];
            }else if(failCount == self.productList.count){
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"所有订单支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"支付成功%ld个，失败%ld个", successCount, failCount] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:self.error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }

    }];
   
}

- (IBAction)pay:(id)sender {
    [self confirmOrder];
}
@end
