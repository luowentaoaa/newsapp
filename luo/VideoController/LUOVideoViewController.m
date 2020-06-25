//
//  LUOVideoViewController.m
//  luo
//
//  Created by luowentao on 2020/6/19.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOVideoViewController.h"
#import "LUOVideoCollectionViewCell.h"
#import "LUOVideoToolbar.h"
@interface LUOVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation LUOVideoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / 16 * 9 + LUOVideoToolbarHeight);
    
    UICollectionView *collectionView = [[UICollectionView alloc]  initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[LUOVideoCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];

    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //需要返回数据个数
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:[LUOVideoCollectionViewCell class]]) {
        //方便讲解事例数据
        [(LUOVideoCollectionViewCell *)cell layoutWithVideoCoverUrl:@"videoCover" videoUrl:@"https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4"];
    }
    return cell;
}




@end
