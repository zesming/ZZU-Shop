//
//  BIDChangePasswordViewController.m
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDChangePasswordViewController.h"
#import "BIDUsers.h"
#import "general.h"

@interface BIDChangePasswordViewController ()

@end

@implementation BIDChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    
    //设置对话框文字
    hud.labelText = @"正在处理，请稍等...";
    [self.view addSubview:hud];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard
{
    [self.oldPasswordTextField resignFirstResponder];
    [self.theNewPasswordTextField resignFirstResponder];
    [self.theNewPasswordConfirmTextField resignFirstResponder];
}

- (IBAction)hideKeyboardByTouch:(id)sender
{
    [self hideKeyboard];
}

- (IBAction)isPasswordEqual:(id)sender
{
    if ([self.theNewPasswordTextField.text isEqualToString:self.theNewPasswordConfirmTextField.text]) {
        return;
    }else{
        [[[UIAlertView alloc] initWithTitle:@"警告" message:@"您两次输入的密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}


- (IBAction)changePassword:(id)sender {
    [self hideKeyboard];
    if (self.oldPasswordTextField.text.length > 0 && self.theNewPasswordTextField.text.length > 0 && self.theNewPasswordConfirmTextField.text.length > 0) {
        BIDUsers *userChangePassword = [BIDUsers new];
        if ([userChangePassword.password isEqualToString:self.oldPasswordTextField.text]) {
            userChangePassword.theNewPassword = self.theNewPasswordConfirmTextField.text;
            [hud showAnimated:YES whileExecutingBlock:^{
                [userChangePassword changePassword];
            }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
                if (!userChangePassword.requestError) {
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:userChangePassword.userData options:NSJSONReadingMutableLeaves error:nil];
                    NSInteger resultCode = [resultDic[@"resultcode"] intValue];
                    if (resultCode == 200) {
                        [[[UIAlertView alloc] initWithTitle:@"成功" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                        NSString *url = [NSString stringWithFormat:@"%@%@", filePath, @"userInfo.plist"];
                        NSFileManager *logoutFileManager = [NSFileManager new];
                        [logoutFileManager removeItemAtPath:url error:nil];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [[[UIAlertView alloc] initWithTitle:@"警告" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    }
                }
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"警告" message:@"您的当前密码有误，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
    }[[[UIAlertView alloc] initWithTitle:@"警告" message:@"请完整输入修改信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}
@end
