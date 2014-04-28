//
//  BIDPersonalRecListTableViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDUsers.h"
#import "BIDImageDownload.h"
#import "BIDPersonalRecTableViewCell.h"
#import "MBProgressHUD.h"

@interface BIDPersonalRecListTableViewController : UITableViewController
{
    MBProgressHUD *hud;
    NSInteger s1, s2, s3, s4, s5;
}

@property (nonatomic, strong) NSArray *personalListData;
@property (nonatomic, strong) BIDUsers *userPersonalList;

- (void)getPersonalRecList;

@end
