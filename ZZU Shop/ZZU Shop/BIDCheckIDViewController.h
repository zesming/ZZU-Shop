//
//  BIDCheckIDViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-24.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDCheckIDViewController : UIViewController{
    MBProgressHUD *hud;
    NSInteger checkCode;
}
@property (weak, nonatomic) IBOutlet UITextField *studentID;
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;


- (IBAction)checkInfo:(id)sender;

- (IBAction)hideKeyboard:(id)sender;
@end
