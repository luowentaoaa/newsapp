//
//  LUOMediator.m
//  luo
//
//  Created by luowentao on 2020/6/25.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOMediator.h"

@implementation LUOMediator

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl{
    Class detailCls = NSClassFromString(@"LUODetaiViewController");
    
    UIViewController *controller = [[detailCls alloc] performSelector:@selector(initWithUrlString:) withObject:detailUrl];
    
    return controller;
}


+ (NSMutableDictionary *)mediatorCache{
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

+ (void)registerScheme:(NSString *)scheme processBlock:(LUOMediatorProcessBlock)processBlock{
    if (scheme && processBlock) {
        [[[self class] mediatorCache] setObject:processBlock forKey:scheme];
    }
}

+ (void)openUrl:(NSString *)url params:(NSDictionary *)params{
    LUOMediatorProcessBlock block = [[[self class] mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

@end
