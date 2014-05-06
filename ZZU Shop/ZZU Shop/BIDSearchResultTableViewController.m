//
//  BIDSearchResultTableViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-29.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDSearchResultTableViewController.h"
#import "BIDSearchResultTableViewCell.h"
#import "BIDUILabelStrikeThrough.h"
#import "BIDImageDownload.h"

@interface BIDSearchResultTableViewController ()
{
    NSInteger s1, s2, s3, s4, s5;
    NSInteger totalPageNum;
    NSInteger page;
}

@end

@implementation BIDSearchResultTableViewController

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
    
    self.navigationItem.title = @"查询结果";
    
    page = 1;
    
    /* 对下拉刷新第三方类库进行加载 */
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    
    self.productSearch = [BIDProduct new];
    self.productSearch.page = page;
    self.productSearch.keyWord = self.searchText;
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.productSearch getSearchResult];
    }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
        [self getProductSearchResultList];
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getProductSearchResultList
{
    if (!self.productSearch.requestError) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.productSearch.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSInteger resultCode = [resultDic[@"resultcode"] intValue];
        if (resultCode == 200){
            self.resultList = [[NSMutableArray alloc] initWithArray:resultDic[@"productInfoList"]];
            if (self.resultList.count == 0) {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"未找到相应商品" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            }
            totalPageNum = [resultDic[@"allPage"]intValue];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:self.productSearch.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BIDSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    cell.resultNameLabel.text = self.resultList[indexPath.row][@"p_name"];
    cell.resultPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.resultList[indexPath.row][@"p_nowPrice"]];
    cell.resultNumberLabel.text = [NSString stringWithFormat:@"%@件", self.resultList[indexPath.row][@"p_number"]];
    
    /* 自定义删除线UILabel */
    NSString *originalPriceStr = [NSString stringWithFormat:@"￥%@", self.resultList[indexPath.row][@"p_originalPrice"]];
    BIDUILabelStrikeThrough *originalPriceLabel = [[BIDUILabelStrikeThrough alloc] initWithFrame:CGRectMake(115, 40, (originalPriceStr.length) * 12 * 0.7 + (originalPriceStr.length -1) * 0.4, 20)];
    originalPriceLabel.text = originalPriceStr;
    originalPriceLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    originalPriceLabel.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    originalPriceLabel.isWithStrikeThrough = YES;
    [cell.contentView addSubview:originalPriceLabel];
    
    s1 = [self.resultList[indexPath.row][@"score_1"]intValue];
    s2 = [self.resultList[indexPath.row][@"score_2"]intValue];
    s3 = [self.resultList[indexPath.row][@"score_3"]intValue];
    s4 = [self.resultList[indexPath.row][@"score_4"]intValue];
    s5 = [self.resultList[indexPath.row][@"score_5"]intValue];
    NSString *rateStr;
    if (s1 == 0 && s2 == 0 && s3 == 0 && s4 == 0 && s5 == 0) {
        rateStr = @"暂无";
    }else{
        float rate = ((float)s1 * 1 + s2 * 2 + s3 * 3 + s4 * 4 + s5 * 5)/(s1 + s2 + s3 + s4 + s5);
        rateStr = [NSString stringWithFormat:@"%.1f分", rate];
    }
    cell.resultRateLabel.text = rateStr;
    
    BIDImageDownload *imageDownload = [BIDImageDownload new];
    imageDownload.url = self.resultList[indexPath.row][@"p_imgPath"];
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
        self.productSearch.page = ++ page;
        [self.productSearch getSearchResult];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.productSearch.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSArray *d = resultDic[@"productInfoList"];
        
        [self.resultList addObjectsFromArray:d];
        /*
        for(NSDictionary *dic in d){
            [self.resultList addObject:dic];
        }
        */
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [[segue destinationViewController] setValue:self.resultList[indexPath.row][@"p_id"] forKey:@"productID"];
}


@end
