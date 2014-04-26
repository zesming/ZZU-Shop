//
//  BIDMyShopTableViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-23.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDMyShopTableViewController.h"
#import "general.h"
#import "BIDUsers.h"

@interface BIDMyShopTableViewController ()

@end

@implementation BIDMyShopTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setUIColor];
    [self setLoginContainView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    BIDUsers *userInfo = [[BIDUsers alloc] init];
    
    if (userInfo.userName || userInfo.nickName || userInfo.email) {
        
        [self isLoginShow];
        self.userNickName.text = userInfo.nickName;
        self.userID.text = [NSString stringWithFormat:@"学号：%@", userInfo.userName];
        self.userEmail.text = [NSString stringWithFormat:@"邮箱：%@", userInfo.email];

    }else{
        [self notLoginShow];
    }
    
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

-(void) setLoginContainView
{
    self.myShopTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myShopTableView.bounds.size.width, 0.1f)];
    self.myShopTopView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"myShop_bg.png"]];
}

- (void)isLoginShow
{
    self.notLoginAlert.hidden = YES;
    self.notLoginButton.hidden = YES;
    
    self.userNickName.hidden = NO;
    self.userID.hidden = NO;
    self.userEmail.hidden = NO;
    self.rightButton.enabled = YES;
    
    self.personalRecCell.userInteractionEnabled = YES;
    self.personalRecLabel.enabled = YES;
    
    /* 订单状态功能未实现，暂时全部不可用 */
    self.notSendCell.userInteractionEnabled = NO;
    self.notSendLabel.enabled = NO;
    self.sentCell.userInteractionEnabled = NO;
    self.sentLabel.enabled = NO;
    self.notGradeCell.userInteractionEnabled = NO;
    self.notGradeLabel.enabled = NO;
    
    self.allListCell.userInteractionEnabled = YES;
    self.allListLabel.enabled = YES;
}

- (void)notLoginShow
{
    self.notLoginAlert.hidden = NO;
    self.notLoginButton.hidden = NO;
    
    self.userNickName.hidden = YES;
    self.userID.hidden = YES;
    self.userEmail.hidden = YES;
    self.rightButton.enabled = NO;
    
    self.personalRecCell.userInteractionEnabled = NO;
    self.personalRecLabel.enabled = NO;
    
    /* 订单状态功能未实现，暂时全部不可用 */
    self.notSendCell.userInteractionEnabled = NO;
    self.notSendLabel.enabled = NO;
    self.sentCell.userInteractionEnabled = NO;
    self.sentLabel.enabled = NO;
    self.notGradeCell.userInteractionEnabled = NO;
    self.notGradeLabel.enabled = NO;
    
    self.allListCell.userInteractionEnabled = NO;
    self.allListLabel.enabled = NO;
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
