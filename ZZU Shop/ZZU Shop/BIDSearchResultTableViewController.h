//
//  BIDSearchResultTableViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-29.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "MBProgressHUD.h"
#import "BIDProduct.h"

@interface BIDSearchResultTableViewController : UITableViewController
{
    MBProgressHUD *hud;
}

@property (strong, nonatomic) IBOutlet PullTableView *pullTableView;
@property (strong, nonatomic) NSMutableArray *resultList;
@property (strong, nonatomic) BIDProduct *productSearch;
@property (strong, nonatomic) NSString *searchText;

- (void)getProductSearchResultList;

@end
