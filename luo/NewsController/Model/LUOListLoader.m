//
//  LUOListLoader.m
//  luo
//
//  Created by luowentao on 2020/6/17.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOListLoader.h"
#import "LUOListItem.h"
#import <AFNetworking.h>

@implementation LUOListLoader

- (void)loadListDataWithFinishBlock:(LUOListLoaderFinishBlock)finishBlock {
    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSURL *listURL = [NSURL URLWithString:urlString];

    NSURLSession *session = [NSURLSession sharedSession];

    NSArray<LUOListItem *> *listdata = [self _readDataFromLocal];
    
    if (listdata) {
        finishBlock(YES, listdata);
    }

    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if ([jsonObj isKindOfClass:[NSDictionary class]]) {
            NSArray *dataArray =  [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
            NSMutableArray *listItemArray = @[].mutableCopy;
            for (NSDictionary *info in dataArray) {
                LUOListItem *listItem = [[LUOListItem alloc] init];
                [listItem configWithDictionary:info];
                [listItemArray addObject:listItem];
            }

            [strongSelf _archiveListDataWithArray:listItemArray.copy];

            dispatch_async(dispatch_get_main_queue(), ^{
                               if (finishBlock) {
                                   finishBlock(error == nil, listItemArray.copy);
                               }
                           });
        }
    }];
    [dataTask resume];
}

#pragma mark - private method

- (NSArray<LUOListItem *> *)_readDataFromLocal {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GTData/list"];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [LUOListItem class], nil]  fromData:readListData error:nil];

    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<LUOListItem *> *)unarchiveObj;
    }
    return nil;
}

- (void)_archiveListDataWithArray:(NSArray<LUOListItem *> *)array {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

    NSFileManager *fileManage = [NSFileManager defaultManager];

    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"LUOData"];
    NSError *creatError;
    [fileManage createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&creatError];

    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fileManage createFileAtPath:listDataPath contents:listData attributes:nil];

//    NSData *readData = [fileManage contentsAtPath:listDataPath];
//
//    id obj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[LUOListItem class], nil] fromData:readData error:nil];
}

@end
