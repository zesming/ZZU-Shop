//
//  BIDMyShopTableViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-23.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDMyShopTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *myShopTopView;
@property (strong, nonatomic) IBOutlet UITableView *myShopTableView;
@property (weak, nonatomic) IBOutlet UILabel *notLoginAlert;
@property (weak, nonatomic) IBOutlet UIButton *notLoginButton;

@property (weak, nonatomic) IBOutlet UILabel *userNickName;
@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;


@end
