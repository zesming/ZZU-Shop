//
//  BIDIndexViewController.h
//  ZZU Shop
//
//  Created by 赵恩生 on 14-4-17.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BIDIndexViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (weak, nonatomic) IBOutlet UIView *topInnerView;
@property (weak, nonatomic) IBOutlet UIView *recommendContainView;
@property (weak, nonatomic) IBOutlet UIButton *indexSearchButton;
@property (weak, nonatomic) IBOutlet UIScrollView *hotScrollView;
@property (weak, nonatomic) IBOutlet UIView *hotInnerView;


@property (weak, nonatomic) IBOutlet UIImageView *productImgView_1;
@property (weak, nonatomic) IBOutlet UIImageView *productImgView_2;
@property (weak, nonatomic) IBOutlet UIImageView *productImgView_3;
@property (weak, nonatomic) IBOutlet UIImageView *productImgView_4;
@property (weak, nonatomic) IBOutlet UIImageView *productImgView_5;

@property (weak, nonatomic) IBOutlet UILabel *hotP_nameLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *hotP_nameLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *hotP_nameLabel_3;
@property (weak, nonatomic) IBOutlet UILabel *hotP_nameLabel_4;
@property (weak, nonatomic) IBOutlet UILabel *hotP_nameLabel_5;

@property (weak, nonatomic) IBOutlet UILabel *hotP_priceLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *hotP_priceLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *hotP_priceLabel_3;
@property (weak, nonatomic) IBOutlet UILabel *hotP_priceLabel_4;
@property (weak, nonatomic) IBOutlet UILabel *hotP_priceLabel_5;

@property (strong, nonatomic) NSArray *recList;


- (void)loginWhenStart;
- (void)getRecProductListWhenStart;
- (void)showRecList;
- (void)setImageViewWithImageView:(UIImageView *) imageView atIndex:(NSInteger) index;
- (void)setNameLabelWithLabel:(UILabel *) label AtIndex:(NSInteger) index;
- (void)setPriceLabelWithLabel:(UILabel *) label AtIndex:(NSInteger) index;
- (void)addGestureToImageView;
- (void)toProductDetailViewControllerWithIndex:(UITapGestureRecognizer *)sender;

@end
