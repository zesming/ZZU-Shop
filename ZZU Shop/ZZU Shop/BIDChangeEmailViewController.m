//
//  BIDChangeEmailViewController.m
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDChangeEmailViewController.h"
#import "BIDUsers.h"

@interface BIDChangeEmailViewController ()

@end

@implementation BIDChangeEmailViewController

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

- (IBAction)hideKeyboard:(id)sender
{
    [self.theNewEmailTExtField resignFirstResponder];
}

- (IBAction)changeEmail:(id)sender {
    [self.theNewEmailTExtField resignFirstResponder];
    if (self.theNewEmailTExtField.text.length >0) {
        BIDUsers *userchangeEmail = [BIDUsers new];
        userchangeEmail.phoneNumber = self.theNewEmailTExtField.text;
        [hud showAnimated:YES whileExecutingBlock:^{
            [userchangeEmail changeEmail];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            if (!userchangeEmail.requestError) {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:userchangeEmail.userData options:NSJSONReadingMutableLeaves error:nil];
                NSInteger resultCode = [resultDic[@"resultcode"] intValue];
                if (resultCode == 200) {
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"成功" message:userchangeEmail.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
        }];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"成功" message:@"请输入您要设置的新安全邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}@end
