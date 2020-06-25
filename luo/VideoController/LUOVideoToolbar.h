//
//  LUOVideoToolbar.h
//  luo
//
//  Created by luowentao on 2020/6/24.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUOScreen.h"

#define LUOVideoToolbarHeight UI(60)

NS_ASSUME_NONNULL_BEGIN

@interface LUOVideoToolbar : UIView
- (void)layoutWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
