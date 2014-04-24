//
//  BIDShoppingCartViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-17.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDShoppingCartViewController.h"

@interface BIDShoppingCartViewController ()

@end

@implementation BIDShoppingCartViewController

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
    [self setNothingView];
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
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    //导航栏其他颜色设置
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置标签栏选中颜色
    self.tabBarController.tabBar.tintColor = lightGreenColor;
}

- (void)setNothingView
{
    self.nothingDiscrption.text = @"购物车应该为您购物提供服务，它是非常有用的购物工具，请不要让它过于空虚~";
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
