//
//  LUOLogin.h
//  luo
//
//  Created by luowentao on 2020/6/25.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LUOLoginFinishBlock)(BOOL isLogin);

@interface LUOLogin : NSObject

@property(nonatomic, copy) NSString *nick;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *avatarUrl;


+ (instancetype)sharedLogin;

#pragma - mark - 登录

- (BOOL)isLogin;
- (void)loginWithFinishBlock:(LUOLoginFinishBlock)finishBlock;
- (void)logOut;

#pragma mark - 分享
- (void)shareToQQWithArticleUrl:(NSURL *)articleUrl;
@end

NS_ASSUME_NONNULL_END
