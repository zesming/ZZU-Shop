//
//  BIDRateProductViewController.h
//  郑大商城
//
//  Created by Ming on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BIDRateProductViewController : UIViewController<UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    MBProgressHUD *hud;
}

@property (assign, nonatomic) NSInteger productID;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) UIImage *img;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UITextField *rateTextFile;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)rateProduct:(id)sender;

@end
