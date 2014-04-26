//
//  BIDRegisterViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-22.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDRegisterViewController.h"
#import "BIDUsers.h"

@interface BIDRegisterViewController ()
{
    UIActionSheet *sheet;
    UIPickerView *picker;
    NSInteger questionID;
}

@end

@implementation BIDRegisterViewController

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
    
    [self getQuestionsList];
    
    self.answerTextField.delegate = self;
    self.studentIDLabel.text = self.studentID;
    self.realNameLabel.text = self.realName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getQuestionsList{
    BIDUsers *questions = [BIDUsers new];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [questions getQuestionsList];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!questions.requestError) {
                NSDictionary *questionsDic = [NSJSONSerialization JSONObjectWithData:questions.userData options:NSJSONReadingMutableLeaves error:nil];
                int resultCode = [questionsDic[@"resultcode"] intValue];
                if (resultCode == 200) {
                    NSArray *data = questionsDic[@"questionsList"];
                    self.questionsList = [NSMutableArray new];
                    for (NSDictionary *dic in data)
                        [self.questionsList addObject:dic[@"question"]];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:questionsDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"警告" message:questions.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
        });
    });
}

- (void) doneSelecting
{
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    long row = [picker selectedRowInComponent:0];
    questionID = row + 1;
    self.questionTextField.text = self.questionsList[row];
}

- (IBAction)pickerSheet:(id)sender {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    view.backgroundColor = [UIColor whiteColor];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, 320, 220)];
    picker.delegate = self;
    picker.dataSource = self;
    [view addSubview:picker];
    
    // Add the ToolBar
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    pickerToolbar.backgroundColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSelecting)];
    [barItems addObject:doneBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [view addSubview:pickerToolbar];
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"p" destructiveButtonTitle:nil otherButtonTitles:nil];
    [sheet addSubview:view];
    [sheet showFromTabBar:self.tabBarController.tabBar];
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.questionsList count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.questionsList objectAtIndex:row];
}

- (void)hideKeyboard
{
    [self.passwordTextFile resignFirstResponder];
    [self.passwordConfirmTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.answerTextField resignFirstResponder];
}

- (IBAction)touchBackgroundToHideKeyboard:(id)sender
{
    [self hideKeyboard];
}

- (IBAction)registerButton:(id)sender {
    [self hideKeyboard];
    if ([self checkUserInfo]) {
        BIDUsers *userRegister = [BIDUsers new];
        userRegister.userName = self.studentID;
        userRegister.realName = self.realName;
        userRegister.password = self.passwordConfirmTextField.text;
        userRegister.nickName = self.nickNameTextField.text;
        userRegister.email = self.emailTextField.text;
        userRegister.q_id = questionID;
        userRegister.answer = self.answerTextField.text;
        userRegister.phoneNumber = self.phoneNumberTextField.text;
        
        [hud showAnimated:YES whileExecutingBlock:^{
            [userRegister registerNewUser];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            if (!userRegister.requestError) {
                NSDictionary *registerInfo = [NSJSONSerialization JSONObjectWithData:userRegister.userData options:NSJSONReadingMutableLeaves error:nil];
                int resultCode = [registerInfo[@"resultcode"] intValue];
                if (resultCode == 200) {
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:registerInfo[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:registerInfo[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"警告" message:userRegister.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"警告" message:@"请检查注册信息是否完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}



- (IBAction)isPasswordEqual:(id)sender
{
    if ([self.passwordTextFile.text isEqualToString:self.passwordConfirmTextField.text]) {
        return;
    }else{
        [[[UIAlertView alloc] initWithTitle:@"警告" message:@"您两次输入的密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}

- (BOOL)checkUserInfo
{
    if (self.passwordTextFile.text.length >0 && self.passwordConfirmTextField.text.length >0 && self.nickNameTextField.text.length > 0 && self.emailTextField.text.length >0 && questionID >0 && self.answerTextField.text.length >0)
    {
        if ([self.passwordTextFile.text isEqualToString:self.passwordConfirmTextField.text]) {
            return YES;
        }
        
    }
    return NO;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-40,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

//恢复原始视图位置
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
    float Y = 64.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

@end
