//
//  LUONewsViewController.m
//  luo
//
//  Created by luowentao on 2020/6/16.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUONewsViewController.h"
#import "LUONewsTableViewCell.h"
#import "LUOListLoader.h"
#import "LUOListItem.h"
#import "LUODeleteCellView.h"
#import "LUOMediator.h"

@interface LUONewsViewController ()<UITableViewDataSource, UITableViewDelegate, LUONewsTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) LUOListLoader *listLoader;

@end

@implementation LUONewsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[LUOListLoader alloc] init];
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<LUOListItem*> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
    
}

- (void)pushController {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.navigationController.title = @"giao";
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LUONewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[LUONewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }

    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LUOListItem *item = [self.dataArray objectAtIndex:indexPath.row];
//
//    UIViewController *detailController = [LUOMediator detailViewControllerWithUrl:item.articleUrl];
//
//    [self.navigationController pushViewController:detailController animated:YES];
    
    [LUOMediator openUrl:@"detail://" params:@{
        @"url":item.articleUrl,
        @"controller":self.navigationController,
    }];
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton{
    LUODeleteCellView *deleteView = [[LUODeleteCellView alloc] initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];

    __weak typeof(self)wself = self;
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
         __strong typeof(wself) strongSelf = wself;
        NSIndexPath *delIndexPath = [strongSelf.tableView indexPathForCell:tableViewCell];
        if (strongSelf.dataArray.count > delIndexPath.row) {
            //删除数据
            NSMutableArray *dataArrayTmp = [strongSelf.dataArray mutableCopy];
            [dataArrayTmp removeObjectAtIndex:delIndexPath.row];
            strongSelf.dataArray = [dataArrayTmp copy];
            //删除cell
            [strongSelf.tableView deleteRowsAtIndexPaths:@[delIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
     }];
}

@end
