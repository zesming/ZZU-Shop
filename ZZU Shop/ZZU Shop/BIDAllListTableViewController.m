//
//  BIDAllListTableViewController.m
//  郑大商城
//
//  Created by Ming on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDAllListTableViewController.h"
#import "BIDAllListTableViewCell.h"
#import "BIDImageDownload.h"

@interface BIDAllListTableViewController ()
{
    NSInteger totalPageNum;
    NSInteger page;
}

@end

@implementation BIDAllListTableViewController

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
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    
    //设置对话框文字
    hud.labelText = @"正在查询，请稍等...";
    
    [self.view addSubview:hud];
    
    /* 对下拉刷新第三方类库进行加载 */
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    page = 1;
    self.userGetAllList = [BIDUsers new];
    self.userGetAllList.listPage = page;
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.userGetAllList getAllList];
    }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
        [self getUserAllList];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserAllList
{
    if (!self.userGetAllList.requestError) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.userGetAllList.userData options:NSJSONReadingMutableLeaves error:nil];
        NSInteger resultCode = [resultDic[@"resultcode"] intValue];
        if (resultCode == 200){
            self.allListData = [[NSMutableArray alloc] initWithArray:resultDic[@"orderList"]];
            totalPageNum = [resultDic[@"allPage"]intValue];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:self.userGetAllList.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
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
    return self.allListData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BIDAllListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allListCell" forIndexPath:indexPath];
    cell.productNameLabel.text = self.allListData[indexPath.row][@"productInfo"][@"p_name"];
    cell.productPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.allListData[indexPath.row][@"productInfo"][@"p_nowPrice"]];
    cell.productNumLabel.text = [NSString stringWithFormat:@"%@(件)", self.allListData[indexPath.row][@"order"][@"pnum"]];
    cell.productStatusLabel.text = self.allListData[indexPath.row][@"order"][@"shipStatus"];
    
    BIDImageDownload *imageDownload = [BIDImageDownload new];
    imageDownload.url = self.allListData[indexPath.row][@"productInfo"][@"p_imgPath"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [imageDownload imageDownload];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!imageDownload.requestError) {
                cell.imgView.image = [UIImage imageWithData:imageDownload.requestData];
            }else{
                cell.imgView.image = [UIImage imageNamed:@"noimage.png"];
            }
        });
    });
    
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
        self.userGetAllList.listPage = ++ page;
        [self.userGetAllList getAllList];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.userGetAllList.userData options:NSJSONReadingMutableLeaves error:nil];
        NSArray *d = resultDic[@"orderList"];
        
        for(NSDictionary *dic in d){
            [self.allListData addObject:dic];
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



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [[segue destinationViewController] setValue:self.allListData[indexPath.row][@"order"][@"orderNumber"] forKey:@"orderNumber"];
}


@end
