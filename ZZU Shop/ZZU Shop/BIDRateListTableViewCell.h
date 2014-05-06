//
//  BIDRateListTableViewCell.h
//  郑大商城
//
//  Created by 赵恩生 on 14-5-5.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDRateListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRateContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRateScoreLabel;

@end
