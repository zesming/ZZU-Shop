//
//  BIDSearchResultTableViewCell.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-29.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDSearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *resultNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultNumberLabel;

@end
