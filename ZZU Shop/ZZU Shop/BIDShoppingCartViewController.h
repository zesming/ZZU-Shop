//
//  BIDShoppingCartViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-17.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDShoppingCartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *notingContainView;
@property (weak, nonatomic) IBOutlet UITextView *nothingDiscrption;

- (IBAction)goShopping:(id)sender;
@end
