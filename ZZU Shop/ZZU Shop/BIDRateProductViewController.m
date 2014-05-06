//
//  BIDRateProductViewController.m
//  郑大商城
//
//  Created by Ming on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import "BIDRateProductViewController.h"
#import "BIDUsers.h"
#import "BIDProduct.h"

@interface BIDRateProductViewController ()
{
    UIActionSheet *sheet;
    UIPickerView *picker;
    NSInteger rate;
    NSArray *rateList;
}

@end

@implementation BIDRateProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化进度框，置于当前的View当中
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    //如果设置此属性则当前的view置于后台
    //    HUD.dimBackground = YES;
    
    //设置对话框文字
    hud.labelText = @"正在查询，请稍等...";
    
    [self.view addSubview:hud];
    rateList = @[@"1分", @"2分", @"3分", @"4分", @"5分"];
    self.productName.text = self.name;
    self.imgView.image = self.img;
    UIColor *bgImage = [UIColor colorWithPatternImage: [UIImage imageNamed:@"contentView_bg.png"]];
    self.contentView.backgroundColor = bgImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.detailTextView resignFirstResponder];
}

- (void) doneSelecting
{
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
    long row = [picker selectedRowInComponent:0];
    rate = row + 1;
    self.rateTextFile.text = rateList[row];
}

- (IBAction)pickerSheet:(id)sender {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    view.backgroundColor = [UIColor whiteColor];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, 320, 220)];
    picker.delegate = self;
    picker.dataSource = self;
    [view addSubview:picker];
    
    // Add the ToolBar
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    pickerToolbar.backgroundColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSelecting)];
    [barItems addObject:doneBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [view addSubview:pickerToolbar];
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"p" destructiveButtonTitle:nil otherButtonTitles:nil];
    [sheet addSubview:view];
    [sheet showFromTabBar:self.tabBarController.tabBar];
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [rateList count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [rateList objectAtIndex:row];
}


- (IBAction)rateProduct:(id)sender {
    BIDProduct *product = [BIDProduct new];
    product.p_id = self.productID;
    product.pr_score = rate;
    product.pr_content = self.detailTextView.text;
    if (self.rateTextFile.text.length > 0 && self.detailTextView.text.length > 0) {
        [hud showAnimated:YES whileExecutingBlock:^{
            [product productRate];
        }onQueue:dispatch_get_global_queue(0, 0) completionBlock:^{
            if (!product.requestError) {
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:product.requestData options:NSJSONReadingMutableLeaves error:nil];
                int resultCode = [resultDic[@"resultcode"] intValue];
                if (resultCode == 200){
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:product.requestError.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            }
        }];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请认真评价哦~！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}
@end
