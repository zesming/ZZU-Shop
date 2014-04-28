//
//  BIDProductDetailViewController.m
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDProductDetailViewController.h"
#import "BIDProduct.h"
#import "BIDUILabelStrikeThrough.h"

@interface BIDProductDetailViewController ()

@end

@implementation BIDProductDetailViewController

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
    UIColor *bgImage = [UIColor colorWithPatternImage: [UIImage imageNamed:@"topContainView.png"]];
    self.topContainerView.backgroundColor = bgImage;
    self.nameContainerView.backgroundColor = [UIColor clearColor];
    self.priceContainerView.backgroundColor = [UIColor clearColor];
    self.otherContainerView.backgroundColor = [UIColor clearColor];
    
    [self getProductDetail];
    self.containerScrollView.contentSize = CGSizeMake(320, 800);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setValue:self.productImageView.image forKey:@"img"];
    [[segue destinationViewController] setValue:self.productNameLabel.text forKey:@"name"];
    [[segue destinationViewController] setValue:[NSString stringWithFormat:@"%ld",(long)self.productID] forKey:@"productID"];
}


- (void)getProductDetail
{
    if (self.productID > 0) {
        BIDProduct *getProductDetail = [BIDProduct new];
        getProductDetail.p_id = self.productID;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [getProductDetail getOneProductInfo];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!getProductDetail.requestError) {
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:getProductDetail.requestData options:NSJSONReadingMutableLeaves error:nil];
                    NSInteger resultCode = [resultDic[@"resultcode"] intValue];
                    if (resultCode == 200){
                        NSDictionary *productInfoDic = resultDic[@"productInfo"];
                        self.getImg = [BIDImageDownload new];
                        self.getImg.url = productInfoDic[@"p_imgPath"];
                        [self getProductImage];
                        self.productNameLabel.text = productInfoDic[@"p_name"];
                        self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", productInfoDic[@"p_nowPrice"]];
                        
                        /* 自定义删除线UILabel */
                        self.originalPriceStr = [NSString stringWithFormat:@"￥%@",productInfoDic[@"p_originalPrice"]];
                        BIDUILabelStrikeThrough *originalPriceLabel = [[BIDUILabelStrikeThrough alloc] initWithFrame:CGRectMake(223, 21, (self.originalPriceStr.length) * 12 * 0.7 + (self.originalPriceStr.length -1) * 0.4, 15)];
                        originalPriceLabel.text = self.originalPriceStr;
                        originalPriceLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
                        originalPriceLabel.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
                        originalPriceLabel.isWithStrikeThrough = YES;
                        [self.priceContainerView addSubview:originalPriceLabel];
                        self.productStorageNumber.text = [NSString stringWithFormat:@"%@件", productInfoDic[@"p_number"]];
                        
                        NSInteger s1, s2, s3, s4, s5;
                        s1 = [productInfoDic[@"score_1"]intValue];
                        s2 = [productInfoDic[@"score_2"]intValue];
                        s3 = [productInfoDic[@"score_3"]intValue];
                        s4 = [productInfoDic[@"score_4"]intValue];
                        s5 = [productInfoDic[@"score_5"]intValue];
                        float rate = ((float)s1 * 1 + s2 * 2 + s3 * 3 + s4 * 4 + s5 * 5)/(s1 + s2 + s3 + s4 + s5);
                        NSString *rateStr = [NSString stringWithFormat:@"%.1f分", rate];
                        self.rateLabel.text = rateStr;
                        self.productDescriptionTextView.text = [NSString stringWithFormat:@"商品描述\n\n%@", productInfoDic[@"p_description"]];
                    }
                }
            });
        });
    }
}

- (void)getProductImage
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.getImg imageDownload];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.getImg.requestError) {
                self.productImageView.image = [UIImage imageWithData:self.getImg.requestData];
            }else{
                self.productImageView.image = [UIImage imageNamed:@"noimage.png"];
            }
        });
    });
}

- (IBAction)addInShopCart:(id)sender {
}
@end
