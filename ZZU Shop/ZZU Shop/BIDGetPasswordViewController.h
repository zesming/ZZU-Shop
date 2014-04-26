//
//  BIDGetPasswordViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-26.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDGetPasswordViewController : UIViewController
{
    MBProgressHUD *hud;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentValue;

@property (weak, nonatomic) IBOutlet UIView *questionView;
@property (weak, nonatomic) IBOutlet UIView *emailView;

@property (weak, nonatomic) IBOutlet UITextField *questionStudentIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailStudentIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)hideKeyboardByTouch:(id)sender;
- (void)hideKeyboard;

- (IBAction)chooseGetPasswordWay:(id)sender;
- (IBAction)getPassword:(id)sender;
@end
