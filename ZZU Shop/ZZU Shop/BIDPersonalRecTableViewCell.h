//
//  BIDPersonalRecTableViewCell.h
//  郑大商城
//
//  Created by Ming on 14-4-27.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BIDPersonalRecTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;


@end
