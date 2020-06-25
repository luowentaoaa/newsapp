//
//  LUOListLoader.h
//  luo
//
//  Created by luowentao on 2020/6/17.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LUOListItem;

typedef void(^LUOListLoaderFinishBlock)(BOOL success, NSArray<LUOListItem *> *dataArray);

@interface LUOListLoader : NSObject
- (void)loadListDataWithFinishBlock:(LUOListLoaderFinishBlock)finishBlock;
@end

NS_ASSUME_NONNULL_END
