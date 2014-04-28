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
    UIActionSheet *sheet;
    UIPickerView *picker;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getQuestionsList];
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
    [self hideKeyboard];
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
                        NSString *resultMsg = [NSString stringWithFormat:@"\n您的密码是：%@\n建议您立即修改", resultDic[@"user"][@"password"]];
                        [[[UIAlertView alloc] initWithTitle:resultDic[@"reason"] message:resultMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
                        NSString *resultMsg = [NSString stringWithFormat:@"\n您的密码是：%@\n建议您立即修改", resultDic[@"user"][@"password"]];
                        [[[UIAlertView alloc] initWithTitle:resultDic[@"reason"] message:resultMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
