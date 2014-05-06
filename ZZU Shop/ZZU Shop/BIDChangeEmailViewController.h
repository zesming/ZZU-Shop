//
//  BIDChangeEmailViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDChangeEmailViewController : UIViewController
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UILabel *currentEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *theNewEmailTExtField;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)changeEmail:(id)sender;

@end
