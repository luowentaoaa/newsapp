//
//  LUOLogin.m
//  luo
//
//  Created by luowentao on 2020/6/25.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOLogin.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface LUOLogin ()<TencentSessionDelegate,TencentLoginDelegate>
@property (nonatomic, strong, readwrite) TencentOAuth *oauth;
@property (nonatomic, copy, readwrite) LUOLoginFinishBlock finishBlock;
@property (nonatomic, assign, readwrite) BOOL isLogin;
@end

@implementation LUOLogin

+ (instancetype)sharedLogin{
    static LUOLogin *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[LUOLogin alloc] init];
    });
    return login;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _isLogin = NO;
        _oauth = [[TencentOAuth alloc] initWithAppId:@"123" andDelegate:self];
    }
    return self;
}

- (BOOL)isLogin {
    //登陆态失效的逻辑
    return _isLogin;
}
- (void)loginWithFinishBlock:(LUOLoginFinishBlock)finishBlock {
    
    _finishBlock = [finishBlock copy];
    
    _oauth.authMode = kAuthModeClientSideToken;
    [_oauth authorize:@[kOPEN_PERMISSION_GET_USER_INFO,
                        kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                        kOPEN_PERMISSION_ADD_ALBUM,
                        kOPEN_PERMISSION_ADD_ONE_BLOG,
                        kOPEN_PERMISSION_ADD_SHARE,
                        kOPEN_PERMISSION_ADD_TOPIC,
                        kOPEN_PERMISSION_CHECK_PAGE_FANS,
                        kOPEN_PERMISSION_GET_INFO,
                        kOPEN_PERMISSION_GET_OTHER_INFO,
                        kOPEN_PERMISSION_LIST_ALBUM,
                        kOPEN_PERMISSION_UPLOAD_PIC,
                        kOPEN_PERMISSION_GET_VIP_INFO,
                        kOPEN_PERMISSION_GET_VIP_RICH_INFO]];
}
- (void)logOut {
    [_oauth logout:self];
    _isLogin = NO;
}


#pragma mark - delegate

- (void)tencentDidLogin {
    _isLogin = YES;
    //保存openid
    [_oauth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (_finishBlock) {
        _finishBlock(NO);
    }
}

- (void)tencentDidNotNetWork {
    
}



- (void)getUserInfoResponse:(APIResponse *)response {
    NSDictionary *userInfo = response.jsonResponse;
    _nick = userInfo[@"nickname"];
    _address = userInfo[@"city"];
    _avatarUrl = userInfo[@"figureurl_qq_2"];
    if (_finishBlock) {
        _finishBlock(YES);
    }
}

- (void)shareToQQWithArticleUrl:(NSURL *)articleUrl {

    //登陆校验
    //loginWithFinishBlock

    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:articleUrl title:@"luo" description:@"luowentao" previewImageURL:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    __unused QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}


@end
