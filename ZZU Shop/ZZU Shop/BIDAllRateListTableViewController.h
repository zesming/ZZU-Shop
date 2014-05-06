//
//  BIDAllRateListTableViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "MBProgressHUD.h"
#import "BIDProduct.h"

@interface BIDAllRateListTableViewController : UITableViewController
{
    MBProgressHUD *hud;
}
@property (strong, nonatomic) IBOutlet PullTableView *pullTableView;
@property (assign, nonatomic) NSInteger productID;
@property (strong, nonatomic) BIDProduct *allRateList;
@property (strong, nonatomic) NSMutableArray *rateList;

- (void)getRateList;

@end
