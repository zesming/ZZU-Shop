//
//  BIDShoppingCartTableViewController.h
//  郑大商城
//
//  Created by Ming on 14-5-4.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "MBProgressHUD.h"
#import "BIDProduct.h"
#import "BIDUsers.h"

@interface BIDShoppingCartTableViewController : UITableViewController
{
    MBProgressHUD *hud;
}

@property (strong, nonatomic) IBOutlet PullTableView *pullTableView;
@property (strong, nonatomic) NSMutableArray *shoppingCartList, *cartIDList;
@property (strong, nonatomic) BIDProduct *getShoppingCart;
@property (strong, nonatomic) BIDUsers *userInfo;

- (void)getShoppingCartList;
- (void)getListData;
- (IBAction)payThem:(id)sender;
- (IBAction)textFieldDoneEditting:(id)sender;
@end
