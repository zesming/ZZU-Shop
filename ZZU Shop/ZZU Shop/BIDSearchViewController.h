//
//  BIDSearchViewController.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-17.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)hideKeyboard:(id)sender;
@end
