//
//  BIDOrderListDetailViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDOrderListDetailViewController.h"

@interface BIDOrderListDetailViewController ()

@end

@implementation BIDOrderListDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewBackground];
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"正在查询...";
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    [self.view addSubview:hud];
    self.getOneOrder = [BIDProduct new];
    self.getOneOrder.orderNumber = self.orderNumber;
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.getOneOrder getOrderDetail];
    }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
        [self getOrderDetail];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewBackground
{
    UIColor *topBgImage = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_top_bg.png"]];
    UIColor *midBgImage = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_mid_bg.png"]];
    UIColor *botBgImage = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_bot_bg.png"]];
    
    self.topView.backgroundColor = topBgImage;
    self.midView.backgroundColor = midBgImage;
    self.botView.backgroundColor = botBgImage;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
}

- (void)getOrderDetail
{
    if (!self.getOneOrder.requestError) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.getOneOrder.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSInteger resultCode = [resultDic[@"resultcode"] integerValue];
        if (resultCode == 200){
            self.p_id = [resultDic[@"orderProductInfo"][@"productInfo"][@"p_id"] integerValue];
            self.userNameLabel.text = resultDic[@"orderProductInfo"][@"order"][@"studentID"];
            self.userAddrLabel.text = resultDic[@"orderProductInfo"][@"order"][@"address"];
            self.getImg = [BIDImageDownload new];
            self.getImg.url = resultDic[@"orderProductInfo"][@"productInfo"][@"p_imgPath"];
            [self getProductImage];
            
            self.productNameLabel.text = resultDic[@"orderProductInfo"][@"productInfo"][@"p_name"];
            self.productPriceLabel.text = [NSString stringWithFormat:@"￥%@", resultDic[@"orderProductInfo"][@"productInfo"][@"p_nowPrice"]];
            self.productNumLabel.text = [NSString stringWithFormat:@"x%@", resultDic[@"orderProductInfo"][@"order"][@"pnum"]];
            self.orderIDLabel.text = self.orderNumber;
            self.orderTimeLabel.text = [NSString stringWithFormat:@"%@年%@月%@日 %@", resultDic[@"orderProductInfo"][@"order"][@"year"], resultDic[@"orderProductInfo"][@"order"][@"month"], resultDic[@"orderProductInfo"][@"order"][@"day"], resultDic[@"orderProductInfo"][@"order"][@"o_time"]];
            self.remainingTimeLabel.text = [NSString stringWithFormat:@"%@天", resultDic[@"orderProductInfo"][@"order"][@"arrivalTime"]];
            NSString *shipStatusStr = [NSString stringWithFormat:@"%@", resultDic[@"orderProductInfo"][@"order"][@"shipStatus"]];
            if ([shipStatusStr isEqualToString:@"未发货"]) {
                self.cancleButton.enabled = YES;
            }else{
                self.cancleButton.enabled = NO;
            }
            
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }else{
         [[[UIAlertView alloc] initWithTitle:@"提示" message:self.getOneOrder.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

- (IBAction)cancleOrder:(id)sender {
    self.getOneOrder = [BIDProduct new];
    self.getOneOrder.orderNumber = self.orderNumber;
    hud.labelText = @"正在处理...";
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.getOneOrder cancleOrder];
    }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
        if (!self.getOneOrder.requestError) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.getOneOrder.requestData options:NSJSONReadingMutableLeaves error:nil];
            NSInteger resultCode = [resultDic[@"resultcode"] integerValue];
            if (resultCode == 200){
                [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            }
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:self.getOneOrder.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }];
}
- (void)getProductImage
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.getImg imageDownload];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.getImg.requestError) {
                self.productImageView.image = [UIImage imageWithData:self.getImg.requestData];
            }else{
                self.productImageView.image = [UIImage imageNamed:@"noimage.png"];
            }
        });
    });
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setValue:[NSString stringWithFormat:@"%ld", self.p_id] forKey:@"productID"];
}
@end
