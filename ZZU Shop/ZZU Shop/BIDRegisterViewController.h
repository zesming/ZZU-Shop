//
//  BIDRegisterViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-22.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDRegisterViewController : UIViewController<UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    MBProgressHUD *hud;
}

@property (strong, nonatomic) NSString *studentID, *realName;
@property (strong, nonatomic) NSMutableArray *questionsList;
@property (weak, nonatomic) IBOutlet UILabel *studentIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFile;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

- (void)hideKeyboard;
- (IBAction)touchBackgroundToHideKeyboard:(id)sender;
- (IBAction)registerButton:(id)sender;
- (void)getQuestionsList;
- (IBAction)isPasswordEqual:(id)sender;
- (BOOL)checkUserInfo;
@end
