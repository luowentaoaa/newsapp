//
//  LUOVideoCollectionViewCell.m
//  luo
//
//  Created by luowentao on 2020/6/19.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOVideoCollectionViewCell.h"
#import "LUOVideoPlayer.h"
#import "LUOVideoToolbar.h"
#import "LUOScreen.h"
@interface LUOVideoCollectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) LUOVideoToolbar *toolbar;
@end

@implementation LUOVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height - LUOVideoToolbarHeight)];
            _coverView;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - UI(50)) / 2, (frame.size.height - LUOVideoToolbarHeight - UI(50)) / 2, UI(50), UI(50))];
            _playButton.image = [UIImage imageNamed:@"videoPlay"];
            _playButton;
        })];
        [self addSubview:({
            _toolbar = [[LUOVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, LUOVideoToolbarHeight)];
            _toolbar;
        })];
        
        //点击全部Item都支持播放
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        

    }
    return self;
}

- (void)dealloc
{
    

}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
}

- (void)_tapToPlay{
    [[LUOVideoPlayer Player] playVideoWithVideoUrl:_videoUrl attachView:_coverView];
}

@end
