//
//  BIDMyAccountTableViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-24.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDMyAccountTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

- (IBAction)logoutAccount:(id)sender;
@end
