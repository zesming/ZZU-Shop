//
//  BIDIndexViewController.h
//  ZZU Shop
//
//  Created by 赵恩生 on 14-4-17.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDIndexViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *hotContainView;
@property (weak, nonatomic) IBOutlet UIView *recommendContainView;
@property (weak, nonatomic) IBOutlet UIButton *indexSearchButton;

- (void)loginWhenStart;
@end
