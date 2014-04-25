//
//  BIDCheckIDViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-24.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDCheckIDViewController.h"
#import "BIDUsers.h"

@interface BIDCheckIDViewController ()

@end

@implementation BIDCheckIDViewController

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
    hud.labelText = @"正在验证，请稍等...";
    
    [self.view addSubview:hud];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.studentID resignFirstResponder];
    [self.realName resignFirstResponder];
}

- (IBAction)checkInfo:(id)sender {
    [self.studentID resignFirstResponder];
    [self.realName resignFirstResponder];
    if (self.studentID.text.length > 0 && self.realName.text.length > 0) {
        BIDUsers *userCheck = [BIDUsers new];
        userCheck.userName = self.studentID.text;
        userCheck.realName = self.realName.text;
        
        [hud showAnimated:YES whileExecutingBlock:^{
            [userCheck checkStudentIDAndRealName];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            if (!userCheck.requestError) {
                NSDictionary *checkInfo = [NSJSONSerialization JSONObjectWithData:userCheck.userData options:NSJSONReadingMutableLeaves error:nil];
                checkCode = [checkInfo[@"resultcode"] intValue];
                if (checkCode == 200) {
                     [[[UIAlertView alloc] initWithTitle:@"成功" message:checkInfo[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    self.nextStep.enabled = YES;
                    
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:checkInfo[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"警告" message:userCheck.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入学号和姓名！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
 
    if (checkCode == 200) {
        return YES;
    }
    return NO;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     [[segue destinationViewController] setValue:self.studentID.text forKey:@"studentID"];
     [[segue destinationViewController] setValue:self.realName.text forKey:@"realName"];
 }

@end
