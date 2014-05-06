//
//  BIDShoppingCartTableViewCell.h
//  郑大商城
//
//  Created by Ming on 14-5-4.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDShoppingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topCellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topCellPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *allProductsPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *productNumberTextField;



@end
