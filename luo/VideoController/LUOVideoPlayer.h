//
//  LUOVideoPlayer.h
//  luo
//
//  Created by luowentao on 2020/6/24.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LUOVideoPlayer : NSObject

+ (instancetype)Player;

- (void)playVideoWithVideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
