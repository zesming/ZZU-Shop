//
//  BIDShoppingCartTableViewController.m
//  郑大商城
//
//  Created by Ming on 14-5-4.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDShoppingCartTableViewController.h"
#import "BIDShoppingCartTableViewCell.h"
#import "BIDImageDownload.h"

@interface BIDShoppingCartTableViewController (){
    NSInteger totalPageNum, page, allCount, allPrice;
}

@end

@implementation BIDShoppingCartTableViewController

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
    [self setUIColor];
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    [self.view addSubview:hud];
    /* 对下拉刷新第三方类库进行加载 */
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.shoppingCartList removeAllObjects];
    [self.tableView reloadData];
    [self getListData];

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置标签栏选中颜色
    self.tabBarController.tabBar.tintColor = lightGreenColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getShoppingCartList
{
    if (!self.getShoppingCart.requestError) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.getShoppingCart.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSInteger resultCode = [resultDic[@"resultcode"] integerValue];
        if (resultCode == 200){
            allCount = [resultDic[@"allCount"] integerValue];
            allPrice = [resultDic[@"allPrice"] integerValue];
            totalPageNum = [resultDic[@"allPage"] integerValue];
            self.shoppingCartList = [[NSMutableArray alloc] initWithArray:resultDic[@"shopingCartList"]];
            [self.tableView reloadData];
            if (self.shoppingCartList.count == 0) {
                UIStoryboard *noShoppingCart = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [noShoppingCart instantiateViewControllerWithIdentifier:@"noShoppingCartViewController"];
                [self.navigationController presentViewController:vc animated:YES completion:nil];
            }
            totalPageNum = [resultDic[@"allPage"]intValue];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:self.getShoppingCart.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

- (void)getListData
{
    page = 1;
    hud.labelText = @"正在查询，请稍等...";
    self.userInfo = [BIDUsers new];
    self.getShoppingCart = [BIDProduct new];
    self.getShoppingCart.page = page;
    
    if (self.userInfo.userName && self.userInfo.secretKey) {
        [hud showAnimated:YES whileExecutingBlock:^{
            [self.getShoppingCart getShoppingCart];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            [self getShoppingCartList];
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请在登录后查看您的购物车信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }

}

- (IBAction)payThem:(id)sender {
    UIStoryboard *pay = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [pay instantiateViewControllerWithIdentifier:@"payInfoViewController"];
    [vc setValue:[NSString stringWithFormat:@"￥%ld",(long)allPrice] forKeyPath:@"totalPriceStr"];
    self.cartIDList = [NSMutableArray new];
    for (NSInteger i = 0; i < self.shoppingCartList.count; i ++) {
        [self.cartIDList addObject:self.shoppingCartList[i][@"shoppingCart"][@"cart_id"]];
    }
    [vc setValue:self.cartIDList forKeyPath:@"productList"];
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)textFieldDoneEditting:(UITextField *)sender
{
    [sender resignFirstResponder];
    NSInteger index = [sender tag];
    if ([[sender text] integerValue] == [self.shoppingCartList[index][@"shoppingCart"][@"pnum"] integerValue]) {
        return;
    }else{
        BIDProduct *changeCartNumber = [BIDProduct new];
        NSInteger num = [[sender text] integerValue];
        changeCartNumber.cart_id = [self.shoppingCartList[index][@"shoppingCart"][@"cart_id"] integerValue];
        changeCartNumber.pnum = num;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [changeCartNumber changeShoppingCartNumber];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!changeCartNumber.requestError) {
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:changeCartNumber.requestData options:NSJSONReadingMutableLeaves error:nil];
                    NSInteger resultCode = [resultDic[@"resultcode"] integerValue];
                    if (resultCode == 200){
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                        [self getListData];
                    }else{
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                        [self.tableView reloadData];
                    }
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:changeCartNumber.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                }
            });
        });
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shoppingCartList.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        BIDShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell" forIndexPath:0];
        cell.topCellTitleLabel.text = [NSString stringWithFormat:@"小计(%ld件商品):",allCount];
        cell.topCellPriceLabel.text = [NSString stringWithFormat:@"￥%ld",allPrice];
        return cell;
    }else{
        BIDShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCartCell" forIndexPath:indexPath];
        cell.productNameLabel.text = self.shoppingCartList[indexPath.row - 1][@"productInfo"][@"p_name"];
        cell.productPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.shoppingCartList[indexPath.row - 1][@"productInfo"][@"p_nowPrice"]];
        
        cell.productNumberTextField.text = [NSString stringWithFormat:@"%@", self.shoppingCartList[indexPath.row - 1][@"shoppingCart"][@"pnum"]];
        cell.productNumberTextField.tag = indexPath.row - 1;
        
        cell.allProductsPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.shoppingCartList[indexPath.row - 1][@"shoppingCart"][@"totalPrice"]];
        BIDImageDownload *imageDownload = [BIDImageDownload new];
        imageDownload.url = self.shoppingCartList[indexPath.row - 1][@"productInfo"][@"p_imgPath"];
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
    return nil;
}

/* 下拉刷新具体实现 */
- (void) refreshTable
{
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
    [self getListData];
    [self.tableView reloadData];
}

/* 上拉刷新具体实现 */
- (void) loadMoreDataToTable
{
    if (page + 1 <= totalPageNum) {
        self.getShoppingCart.page = ++ page;
        [self.getShoppingCart getShoppingCart];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.getShoppingCart.requestData options:NSJSONReadingMutableLeaves error:nil];
        NSArray *d = resultDic[@"shopingCartList"];
        
        for(NSDictionary *dic in d){
            [self.shoppingCartList addObject:dic];
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




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        hud.labelText = @"正在删除...";
        [hud showAnimated:YES whileExecutingBlock:^{
            self.getShoppingCart = [BIDProduct new];
            self.getShoppingCart.cart_id = [self.shoppingCartList[indexPath.row -1][@"shoppingCart"][@"cart_id"] integerValue];
            [self.getShoppingCart removeOneShoppingCart];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            if (!self.getShoppingCart.requestError) {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:self.getShoppingCart.requestData options:NSJSONReadingMutableLeaves error:nil];
                NSInteger resultCode = [resultDic[@"resultcode"] intValue];
                if (resultCode == 200){
                    allCount --;
                    allPrice = allPrice - [self.shoppingCartList[indexPath.row - 1][@"shoppingCart"][@"totalPrice"]integerValue];
                    [self.shoppingCartList removeObjectAtIndex:(indexPath.row - 1)];
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView reloadData];
                    if (self.shoppingCartList.count == 0) {
                        UIStoryboard *noShoppingCart = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UIViewController *vc = [noShoppingCart instantiateViewControllerWithIdentifier:@"noShoppingCartViewController"];
                        [self.navigationController presentViewController:vc animated:YES completion:nil];
                    }
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:self.getShoppingCart.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            }

        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [[segue destinationViewController] setValue:self.shoppingCartList[indexPath.row - 1][@"productInfo"][@"p_id"] forKey:@"productID"];
}


@end
