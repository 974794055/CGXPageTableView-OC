//
//  CGXPageTableUpdateCellDelegate.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CGXPageTableBaseRowModel;
@protocol CGXPageTableUpdateCellDelegate <NSObject>

@required

@optional
/*
 cellModel:每个item的数据源
 index:分区所在的下标
 */
- (void)updateWithCGXPageTableCellModel:(CGXPageTableBaseRowModel *)cellModel AtIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
