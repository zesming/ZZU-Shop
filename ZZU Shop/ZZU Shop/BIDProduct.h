//
//  BIDProduct.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDProduct : NSObject

@property (nonatomic, assign) NSInteger p_id, pr_score;
@property (nonatomic, strong) NSData *requestData;
@property (nonatomic, strong) NSError *requestError;
@property (nonatomic, strong) NSString *pr_content;

- (void)getOneProductInfo;
- (void)productRate;

@end
