//
//  BIDAllRateListTableViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDAllRateListTableViewController.h"
#import "BIDRateListTableViewCell.h"
#import "BIDImageDownload.h"

@interface BIDAllRateListTableViewController ()
{
    NSInteger totalPageNum, page;
}

@end

@implementation BIDAllRateListTableViewController

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
    self.title = @"全部评论";
    
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    //设置对话框文字
    hud.labelText = @"正在查询，请稍等...";
    [self.view addSubview:hud];
    /* 对下拉刷新第三方类库进行加载 */
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    
    page = 1;
    self.allRateList = [BIDProduct new];
    self.allRateList.p_id = self.productID;
    self.allRateList.page = page;
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.allRateList getRateList];
    }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
        [self getRateList];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getRateList
{
    if (!self.allRateList.requestError) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.allRateList.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSInteger resultCode = [resultDic[@"resultcode"] integerValue];
        if (resultCode == 200){
            totalPageNum = [resultDic[@"allPage"] integerValue];
            self.rateList = [[NSMutableArray alloc] initWithArray:resultDic[@"productReviewsList"]];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:self.allRateList.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.rateList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BIDRateListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rateDetailCell" forIndexPath:indexPath];
    cell.userNickNameLabel.text = self.rateList[indexPath.row][@"user"][@"nickName"];
    cell.userRateScoreLabel.text = [NSString stringWithFormat:@"%@分", self.rateList[indexPath.row][@"productReviews"][@"pr_score"]];
    cell.userRateContentLabel.text = self.rateList[indexPath.row][@"productReviews"][@"pr_content"];
    cell.userRateTimeLabel.text = self.rateList[indexPath.row][@"productReviews"][@"dateTime"];
    return cell;
}

/* 下拉刷新具体实现 */
- (void) refreshTable
{
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
    [self.pullTableView reloadData];
}

/* 上拉刷新具体实现 */
- (void) loadMoreDataToTable
{
    
    if (page + 1 <= totalPageNum) {
        self.allRateList.page = ++ page;
        [self.allRateList getRateList];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.allRateList.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSArray *d = resultDic[@"productReviewsList"];
        
        for(NSDictionary *dic in d){
            [self.rateList addObject:dic];
        }
        
        [self.pullTableView reloadData];
    }

    self.pullTableView.pullTableIsLoadingMore = NO;
}

/* 实现下拉刷新的方法 */
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.0f];
}

/* 实现上拉刷新的方法 */
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.0f];
}


@end
