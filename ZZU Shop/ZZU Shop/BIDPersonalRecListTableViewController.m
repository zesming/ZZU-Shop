//
//  BIDPersonalRecListTableViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDPersonalRecListTableViewController.h"
#import "BIDUILabelStrikeThrough.h"

@interface BIDPersonalRecListTableViewController ()

@end

@implementation BIDPersonalRecListTableViewController

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
    hud.labelText = @"正在查找，请稍等...";
    [self.view addSubview:hud];
    
    self.userPersonalList = [BIDUsers new];
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.userPersonalList getPersonalRecList];
    }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
        [self getPersonalRecList];
        [self.tableView reloadData];
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPersonalRecList
{
    if (!self.userPersonalList.requestError) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.userPersonalList.userData options:NSJSONReadingMutableLeaves error:nil];
        NSInteger resultCode = [resultDic[@"resultcode"] intValue];
        if (resultCode == 200){
            self.personalListData = resultDic[@"personalizedProductList"];
            if (self.personalListData.count == 0) {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时没有为您推荐的商品" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            }
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:self.userPersonalList.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
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
    return self.personalListData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BIDPersonalRecTableViewCell *cell = [BIDPersonalRecTableViewCell new];
    cell = [tableView dequeueReusableCellWithIdentifier:@"personalRec" forIndexPath:indexPath];
    
    if (self.personalListData.count > 0) {
        cell.titleLabel.text = self.personalListData[indexPath.row][@"p_name"];
        
        NSString *priceStr = [NSString stringWithFormat:@"￥%@", self.personalListData[indexPath.row][@"p_nowPrice"]];
        cell.priceLabel.text = priceStr;
        
        /* 自定义删除线UILabel */
        NSString *originalPriceStr = [NSString stringWithFormat:@"￥%@", self.personalListData[indexPath.row][@"p_originalPrice"]];
        BIDUILabelStrikeThrough *originalPriceLabel = [[BIDUILabelStrikeThrough alloc] initWithFrame:CGRectMake(115, 40, (originalPriceStr.length) * 12 * 0.7 + (originalPriceStr.length -1) * 0.4, 20)];
        originalPriceLabel.text = originalPriceStr;
        originalPriceLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        originalPriceLabel.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
        originalPriceLabel.isWithStrikeThrough = YES;
        [cell.contentView addSubview:originalPriceLabel];
        
        s1 = [self.personalListData[indexPath.row][@"score_1"]intValue];
        s2 = [self.personalListData[indexPath.row][@"score_2"]intValue];
        s3 = [self.personalListData[indexPath.row][@"score_3"]intValue];
        s4 = [self.personalListData[indexPath.row][@"score_4"]intValue];
        s5 = [self.personalListData[indexPath.row][@"score_5"]intValue];
        NSString *rateStr;
        if (s1 == 0 && s2 == 0 && s3 == 0 && s4 == 0 && s5 == 0) {
            rateStr = @"暂无";
        }else{
            float rate = ((float)s1 * 1 + s2 * 2 + s3 * 3 + s4 * 4 + s5 * 5)/(s1 + s2 + s3 + s4 + s5);
            rateStr = [NSString stringWithFormat:@"%.1f分", rate];
        }
        cell.rateLabel.text = rateStr;
        
        BIDImageDownload *imageDownload = [BIDImageDownload new];
        imageDownload.url = self.personalListData[indexPath.row][@"p_imgPath"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [imageDownload imageDownload];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!imageDownload.requestError) {
                    cell.img.image = [UIImage imageWithData:imageDownload.requestData];
                }else{
                    cell.img.image = [UIImage imageNamed:@"noimage.png"];
                }
            });
        });
        
    }
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [[segue destinationViewController] setValue:self.personalListData[indexPath.row][@"p_id"] forKey:@"productID"];
}


@end
