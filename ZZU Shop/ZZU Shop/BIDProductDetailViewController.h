//
//  BIDProductDetailViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDImageDownload.h"

@interface BIDProductDetailViewController : UIViewController

@property (assign, nonatomic) NSInteger productID;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) BIDImageDownload *getImg;
@property (strong, nonatomic) NSString *originalPriceStr;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (weak, nonatomic) IBOutlet UIView *nameContainerView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIView *priceContainerView;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productStorageNumber;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIView *otherContainerView;
@property (weak, nonatomic) IBOutlet UITextView *productDescriptionTextView;

- (void)getProductDetail;
- (void)getProductImage;

- (IBAction)addInShopCart:(id)sender;

@end
