//
//  BIDAllListTableViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "MBProgressHUD.h"
#import "BIDUsers.h"

@interface BIDAllListTableViewController : UITableViewController
{
    MBProgressHUD *hud;
}
@property (strong, nonatomic) IBOutlet PullTableView *pullTableView;
@property (strong, nonatomic) BIDUsers *userGetAllList;
@property (strong, nonatomic) NSMutableArray *allListData;

- (void)getUserAllList;

@end
