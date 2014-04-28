//
//  BIDUsers.h
//  郑大商城
//
//  Created by 赵恩生 on 14-4-22.
//  Copyright (c) 2014年 Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDUsers : NSObject


@property (strong, nonatomic) NSString *userName, *password, *nickName ,*email, *phoneNumber, *answer, *realName, *theNewPassword, *secretKey;
@property (strong, nonatomic) NSData *userData;
@property (strong, nonatomic) NSError *requestError;
@property (assign, nonatomic) NSInteger q_id, listPage;

- (id)init;
- (void)loginRequest;
- (void)writeUserInfoToFileWithUserInfo:(NSDictionary *)userInfo;
- (void)checkStudentIDAndRealName;
- (void)getQuestionsList;
- (void)registerNewUser;
- (void)getPasswordBackByQuestion;
- (void)getPasswordBackByEmail;
- (void)changePassword;
- (void)changeNickName;
- (void)changePhoneNumber;
- (void)changeEmail;
- (void)getPersonalRecList;
- (void)getAllList;

@end
