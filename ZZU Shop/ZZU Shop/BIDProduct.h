//
//  BIDProduct.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDProduct : NSObject

@property (nonatomic, assign) NSInteger p_id, pr_score, page, pnum, cart_id, order_id;
@property (nonatomic, strong) NSData *requestData;
@property (nonatomic, strong) NSError *requestError;
@property (nonatomic, strong) NSString *pr_content, *keyWord, *orderNumber;

- (void)getOneProductInfo;
- (void)productRate;
- (void)getRecProductList;
- (void)getSearchResult;
- (void)addOneInShoppingCart;
- (void)getShoppingCart;
- (void)changeShoppingCartNumber;
- (void)removeOneShoppingCart;
- (void)addOneOrder;
- (void)getRateList;
- (void)getOrderDetail;
- (void)cancleOrder;
@end
