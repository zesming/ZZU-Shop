//
//  BIDLoginViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-18.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDLoginViewController : UIViewController{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UIView *LoginContainView;
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *passwdView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextFiled;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)login:(id)sender;
@end
