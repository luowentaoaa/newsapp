//
//  LUOMediator.h
//  luo
//
//  Created by luowentao on 2020/6/25.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LUOMediator : NSObject

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

typedef void(^LUOMediatorProcessBlock)(NSDictionary *params);

+ (void)registerScheme:(NSString *)scheme processBlock:(LUOMediatorProcessBlock)processBlock;

+ (void)openUrl:(NSString *)url params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
