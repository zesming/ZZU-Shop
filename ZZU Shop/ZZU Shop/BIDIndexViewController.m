//
//  BIDIndexViewController.m
//  ZZU Shop
//
//  Created by 赵恩生 on 14-4-17.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDIndexViewController.h"
#import "general.h"
#import "BIDUsers.h"

@interface BIDIndexViewController ()

@end

@implementation BIDIndexViewController

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
    [self setUIColor];
    [self setContainView];
    [self loginWhenStart];
    
}

- (void)setUIColor
{
    //创建浅绿色
    UIColor *lightGreenColor = [UIColor colorWithRed:(125/255.0) green:(216/255.0) blue:(217/255.0) alpha:1.0f];
    //改变状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //导航栏颜色设置
    self.navigationController.navigationBar.barTintColor = lightGreenColor;
    //导航栏标题颜色设置
    //[self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //导航栏其他颜色设置
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置标签栏选中颜色
    self.tabBarController.tabBar.tintColor = lightGreenColor;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)setContainView
{
    UIColor *bgImage = [UIColor colorWithPatternImage: [UIImage imageNamed:@"contain_bg_200.png"]];
    self.hotContainView.backgroundColor = bgImage;
    self.recommendContainView.backgroundColor = bgImage;
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
