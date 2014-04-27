//
//  BIDLoginViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-18.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDLoginViewController.h"
#import "BIDUsers.h"

@interface BIDLoginViewController ()

@end

@implementation BIDLoginViewController

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
    self.title = @"登录";
    [self setLoginView];
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    
    //设置对话框文字
    hud.labelText = @"正在登录，请稍等...";
    
    [self.view addSubview:hud];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

}

- (void)setLoginView
{
    self.LoginContainView.layer.cornerRadius = 6;
    self.LoginContainView.layer.masksToBounds = YES;
    
    self.LoginContainView.layer.borderWidth = 0.5;
    self.LoginContainView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    UIColor *bgImage = [UIColor colorWithPatternImage: [UIImage imageNamed:@"loginContainView_bg.png"]];
    self.LoginContainView.backgroundColor = bgImage;
    
    self.userNameView.backgroundColor = [UIColor clearColor];
    self.passwdView.backgroundColor = [UIColor clearColor];
    
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwdTextFiled resignFirstResponder];
}

- (IBAction)login:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.passwdTextFiled resignFirstResponder];
    
    if (self.userNameTextField.text.length > 0 && self.passwdTextFiled.text.length > 0) {
        BIDUsers *userLogin = [BIDUsers new];
        userLogin.userName = self.userNameTextField.text;
        userLogin.password = self.passwdTextFiled.text;
        
        [hud showAnimated:YES whileExecutingBlock:^{
            [userLogin loginRequest];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            if (!userLogin.requestError) {
                NSDictionary *loginInfo = [NSJSONSerialization JSONObjectWithData:userLogin.userData options:NSJSONReadingMutableLeaves error:nil];
                int resultCode = [loginInfo[@"resultcode"] intValue];
                if (resultCode == 200) {
                    NSDictionary *userInfo = loginInfo[@"user"];
                    [userLogin writeUserInfoToFileWithUserInfo:userInfo];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:loginInfo[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"警告" message:userLogin.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入用户名或密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
