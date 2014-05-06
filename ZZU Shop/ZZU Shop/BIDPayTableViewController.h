//
//  BIDPayTableViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BIDProduct.h"

@interface BIDPayTableViewController : UITableViewController
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) NSString *totalPriceStr;
@property (strong, nonatomic) NSArray *productList;
@property (strong, nonatomic) BIDProduct *addOrder;
@property (strong, nonatomic) NSError *error;

- (void)confirmOrder;
- (IBAction)pay:(id)sender;
@end
