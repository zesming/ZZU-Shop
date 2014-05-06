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
#import "BIDProduct.h"
#import "BIDImageDownload.h"

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
    [self loginWhenStart];
    [self getRecProductListWhenStart];
    [self addGestureToImageView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setContainView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUIColor];
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
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //导航栏其他颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置标签栏选中颜色
    self.tabBarController.tabBar.tintColor = lightGreenColor;
    
    self.topInnerView.backgroundColor = [UIColor clearColor];
    self.hotInnerView.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)setContainView
{
    UIColor *topBgImage = [UIColor colorWithPatternImage:[UIImage imageNamed:@"index_top_container.png"]];
    UIColor *hotBgImage = [UIColor colorWithPatternImage: [UIImage imageNamed:@"contain_bg_200.png"]];
    self.topContainerView.backgroundColor = topBgImage;
    self.recommendContainView.backgroundColor = hotBgImage;
    self.hotScrollView.contentSize = CGSizeMake(670, 205);
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

- (void)getRecProductListWhenStart
{
    BIDProduct *productRecList = [BIDProduct new];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [productRecList getRecProductList];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!productRecList.requestError) {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:productRecList.requestData options:NSJSONReadingMutableLeaves error:nil];
                int resultCode = [resultDic[@"resultcode"] intValue];
                if (resultCode == 200) {
                    self.recList = resultDic[@"topNList"];
                    [self showRecList];
                }else{
                    
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:productRecList.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
        });
    });
}

- (void)showRecList
{
    [self setImageViewWithImageView:self.productImgView_1 atIndex:0];
    [self setImageViewWithImageView:self.productImgView_2 atIndex:1];
    [self setImageViewWithImageView:self.productImgView_3 atIndex:2];
    [self setImageViewWithImageView:self.productImgView_4 atIndex:3];
    [self setImageViewWithImageView:self.productImgView_5 atIndex:4];
    
    [self setNameLabelWithLabel:self.hotP_nameLabel_1 AtIndex:0];
    [self setNameLabelWithLabel:self.hotP_nameLabel_2 AtIndex:1];
    [self setNameLabelWithLabel:self.hotP_nameLabel_3 AtIndex:2];
    [self setNameLabelWithLabel:self.hotP_nameLabel_4 AtIndex:3];
    [self setNameLabelWithLabel:self.hotP_nameLabel_5 AtIndex:4];
    
    [self setPriceLabelWithLabel:self.hotP_priceLabel_1 AtIndex:0];
    [self setPriceLabelWithLabel:self.hotP_priceLabel_2 AtIndex:1];
    [self setPriceLabelWithLabel:self.hotP_priceLabel_3 AtIndex:2];
    [self setPriceLabelWithLabel:self.hotP_priceLabel_4 AtIndex:3];
    [self setPriceLabelWithLabel:self.hotP_priceLabel_5 AtIndex:4];
    
    
}

- (void)setImageViewWithImageView:(UIImageView *)imageView atIndex:(NSInteger)index
{
    BIDImageDownload *getProductImg = [BIDImageDownload new];
    getProductImg.url = self.recList[index][@"p_imgPath"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [getProductImg imageDownload];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!getProductImg.requestError) {
                imageView.image = [UIImage imageWithData:getProductImg.requestData];
            }else{
                imageView.image = [UIImage imageNamed:@"noimage.png"];
            }
        });
    });

}

- (void)setNameLabelWithLabel:(UILabel *)label AtIndex:(NSInteger)index
{
    label.text = self.recList[index][@"p_name"];
}

- (void)setPriceLabelWithLabel:(UILabel *)label AtIndex:(NSInteger)index
{
    
    label.text = [NSString stringWithFormat:@"￥%@", self.recList[index][@"p_nowPrice"]];
}

- (void)addGestureToImageView
{
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toProductDetailViewControllerWithIndex:)];
    [self.productImgView_1 addGestureRecognizer:singleTap1];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toProductDetailViewControllerWithIndex:)];
    [self.productImgView_2 addGestureRecognizer:singleTap2];
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toProductDetailViewControllerWithIndex:)];
    [self.productImgView_3 addGestureRecognizer:singleTap3];
    
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toProductDetailViewControllerWithIndex:)];
    [self.productImgView_4 addGestureRecognizer:singleTap4];
    
    UITapGestureRecognizer *singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toProductDetailViewControllerWithIndex:)];
    [self.productImgView_5 addGestureRecognizer:singleTap5];
    
}

- (void)toProductDetailViewControllerWithIndex:(UITapGestureRecognizer *)sender
{
    
    NSInteger index = 0;
    
    if (sender== self.productImgView_1.gestureRecognizers.lastObject){
        index = 0;
    }else if(sender == self.productImgView_2.gestureRecognizers.lastObject){
        index = 1;
    }else if(sender == self.productImgView_3.gestureRecognizers.lastObject){
        index = 2;
    }else if(sender == self.productImgView_4.gestureRecognizers.lastObject){
        index = 3;
    }else if(sender == self.productImgView_5.gestureRecognizers.lastObject){
        index = 4;
    }
        
    
    UIStoryboard *productDetail = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *destinationViewController = [productDetail instantiateViewControllerWithIdentifier:@"productDetailViewController"];
    [destinationViewController setValue:self.recList[index][@"p_id"] forKeyPath:@"productID"];
    [self.navigationController pushViewController:destinationViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
