//
//  BIDOrderListDetailViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDProduct.h"
#import "BIDImageDownload.h"
#import "MBProgressHUD.h"

@interface BIDOrderListDetailViewController : UIViewController
{
    MBProgressHUD *hud;
}

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *botView;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAddrLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (strong, nonatomic) NSString *orderNumber;
@property (strong, nonatomic) BIDProduct *getOneOrder;
@property (strong, nonatomic) BIDImageDownload *getImg;
@property (assign, nonatomic) NSInteger p_id, order_id;
- (void)getOrderDetail;
- (IBAction)cancleOrder:(id)sender;

@end
