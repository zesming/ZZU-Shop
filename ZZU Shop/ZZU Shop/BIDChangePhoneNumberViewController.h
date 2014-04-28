//
//  BIDChangePhoneNumberViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDChangePhoneNumberViewController : UIViewController
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UILabel *currentPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *theNewPhoneNumberTextField;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)changePhoneNumber:(id)sender;
@end
