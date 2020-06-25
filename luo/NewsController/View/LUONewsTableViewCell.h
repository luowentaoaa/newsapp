//
//  LUONewsTableViewCell.h
//  luo
//
//  Created by luowentao on 2020/6/17.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LUOListItem;

@protocol LUONewsTableViewCellDelegate <NSObject>
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;
@end

@interface LUONewsTableViewCell : UITableViewCell

@property (nonatomic, weak) id<LUONewsTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(LUOListItem *)item;

@end

NS_ASSUME_NONNULL_END
