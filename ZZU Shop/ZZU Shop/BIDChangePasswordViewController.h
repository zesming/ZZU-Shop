//
//  BIDChangePasswordViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDChangePasswordViewController : UIViewController
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordConfirmTextField;

- (void)hideKeyboard;
- (IBAction)hideKeyboardByTouch:(id)sender;

- (IBAction)isPasswordEqual:(id)sender;
- (IBAction)changePassword:(id)sender;
@end
