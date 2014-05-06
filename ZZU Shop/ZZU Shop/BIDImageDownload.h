//
//  BIDImageDownload.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-28.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDImageDownload : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSData *requestData;
@property (nonatomic, strong) NSError *requestError;

- (void)imageDownload;

@end
