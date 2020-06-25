//
//  LUOVideoPlayer.m
//  luo
//
//  Created by luowentao on 2020/6/24.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOVideoPlayer.h"

#import <AVFoundation/AVFoundation.h>

@interface LUOVideoPlayer ()
@property (nonatomic, strong, readwrite) AVAsset *avSet;

@property (nonatomic, strong, readwrite) AVPlayerItem *item;

@property (nonatomic, strong, readwrite) AVPlayer *VideoPlayer;

@property (nonatomic, strong, readwrite) AVPlayerLayer *Playlayer;
@end

@implementation LUOVideoPlayer

+ (instancetype)Player{
    static LUOVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        player = [[LUOVideoPlayer alloc] init];
    });
    return player;
}

- (void)playVideoWithVideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView{
    [self _stopPlay];
    _avSet = [AVAsset assetWithURL:[NSURL URLWithString:videoUrl] ];
    
    _item = [AVPlayerItem playerItemWithAsset:_avSet];
    
    [_item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    CMTime time =  _item.duration;
    CGFloat second = CMTimeGetSeconds(time);
    NSLog(@"sceond = %f",second);
    
    _VideoPlayer = [AVPlayer playerWithPlayerItem:_item];
    
    [_VideoPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度：%@",@(CMTimeGetSeconds(time)));
    }];
    
    _Playlayer = [AVPlayerLayer playerLayerWithPlayer:_VideoPlayer];
    
    _Playlayer.frame = attachView.bounds;
    [attachView.layer addSublayer:_Playlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}


#pragma mark - private method

- (void)_stopPlay {
    [_Playlayer removeFromSuperlayer];
    
    _item = nil;
    _VideoPlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_item removeObserver:self forKeyPath:@"status"];
    [_item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
}
- (void)_handlePlayEnd {
    NSLog(@"a");
    
    

    [_VideoPlayer seekToTime:CMTimeMake(0, 1)];
    [_VideoPlayer play];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerStatusReadyToPlay) {
            [_VideoPlayer play];
        } else {
            NSLog(@"播放不了");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSLog(@"缓冲：%@",[change objectForKey:NSKeyValueChangeNewKey]);
        CMTime time =  _item.duration;
        CGFloat second = CMTimeGetSeconds(time);
        NSLog(@"sceond = %f",second);
        
    }
}
@end
