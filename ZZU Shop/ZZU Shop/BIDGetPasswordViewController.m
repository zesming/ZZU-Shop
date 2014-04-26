//
//  BIDGetPasswordViewController.m
//  郑大商城
//
//  Created by Ming on 14-4-26.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDGetPasswordViewController.h"
#import "BIDUsers.h"

@interface BIDGetPasswordViewController ()
{
    NSInteger questionID;
}

@end

@implementation BIDGetPasswordViewController

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

- (IBAction)hideKeyboardByTouch:(id)sender
{
    [self hideKeyboard];
}

- (void)hideKeyboard
{
    [self.questionStudentIDTextField resignFirstResponder];
    [self.answerTextField resignFirstResponder];
    [self.emailStudentIDTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

- (IBAction)chooseGetPasswordWay:(id)sender {
    if (self.segmentValue.selectedSegmentIndex == 0) {
        self.questionView.hidden = NO;
        self.emailView.hidden = YES;
    }else{
        self.questionView.hidden = YES;
        self.emailView.hidden = NO;
    }
}

- (IBAction)getPassword:(id)sender {
    if (self.segmentValue.selectedSegmentIndex == 0) {
        /* 安全问题找回 */
        if (self.questionStudentIDTextField.text.length > 0 && questionID >0 && self.answerTextField.text.length >0) {
            BIDUsers *getPwByQ = [BIDUsers new];
            getPwByQ.userName = self.questionStudentIDTextField.text;
            getPwByQ.q_id = questionID;
            getPwByQ.answer = self.answerTextField.text;
            [hud showAnimated:YES whileExecutingBlock:^{
                [getPwByQ getPasswordBackByQuestion];
            }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
                if (!getPwByQ.requestError) {
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:getPwByQ.userData options:NSJSONReadingMutableLeaves error:nil];
                    int resultCode = [resultDic[@"resultcode"] intValue];
                    if (resultCode == 200) {
                        [[[UIAlertView alloc] initWithTitle:@"成功" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [[[UIAlertView alloc] initWithTitle:@"警告" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    }
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:getPwByQ.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"警告" message:@"请完整输入找回信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
        
    }else{
        /* 安全邮箱找回 */
        if (self.emailStudentIDTextField.text.length >0 && self.emailTextField.text.length >0) {
            BIDUsers *getPwByE = [BIDUsers new];
            getPwByE.userName = self.emailStudentIDTextField.text;
            getPwByE.email = self.emailTextField.text;
            [hud showAnimated:YES whileExecutingBlock:^{
                [getPwByE getPasswordBackByEmail];
            }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
                if (!getPwByE.requestError) {
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:getPwByE.userData options:NSJSONReadingMutableLeaves error:nil];
                    int resultCode = [resultDic[@"resultcode"] intValue];
                    if (resultCode == 200) {
                        [[[UIAlertView alloc] initWithTitle:@"成功" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [[[UIAlertView alloc] initWithTitle:@"警告" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    }
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:getPwByE.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"警告" message:@"请完整输入找回信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
    }
}
@end
