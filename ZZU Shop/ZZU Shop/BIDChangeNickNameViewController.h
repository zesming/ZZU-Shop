//
//  BIDChangeNickNameViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDChangeNickNameViewController : UIViewController
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UILabel *currentNickNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *theNewNickNameTextField;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)changeNickName:(id)sender;

@end
