//
//  BIDMyAccountTableViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-24.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDMyAccountTableViewController.h"
#import "general.h"
#import "BIDUsers.h"

@interface BIDMyAccountTableViewController ()

@end

@implementation BIDMyAccountTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loginWhenStart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showUserInfo{
    BIDUsers *userInfo = [BIDUsers new];
    
    self.nickNameLabel.text = userInfo.nickName;
    self.phoneNumberLabel.text = userInfo.phoneNumber;
    self.emailLabel.text = userInfo.email;
}

- (void)loginWhenStart
{
    BIDUsers *userInfo = [[BIDUsers alloc] init];
    if (userInfo.userName || userInfo.password) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [userInfo loginRequest];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!userInfo.requestError) {
                    NSDictionary *loginInfo = [NSJSONSerialization JSONObjectWithData:userInfo.userData options:NSJSONReadingMutableLeaves error:nil];
                    int resultCode = [loginInfo[@"resultcode"] intValue];
                    if (resultCode == 200) {
                        NSDictionary *userInfoDic = loginInfo[@"user"];
                        [userInfo writeUserInfoToFileWithUserInfo:userInfoDic];
                        [self showUserInfo];
                    }else{
                        [[[UIAlertView alloc] initWithTitle:@"警告" message:loginInfo[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                        
                        NSFileManager *removeUserInfo = [NSFileManager new];
                        NSString *url = [NSString stringWithFormat:@"%@%@", filePath, @"userInfo.plist"];
                        [removeUserInfo removeItemAtPath:url error:nil];
                    }
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"警告" message:userInfo.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            });
        });
        
    }
}


- (IBAction)logoutAccount:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", filePath, @"userInfo.plist"];
    NSFileManager *logoutFileManager = [NSFileManager new];
    [logoutFileManager removeItemAtPath:url error:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
