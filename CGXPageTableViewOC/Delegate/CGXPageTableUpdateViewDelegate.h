//
//  CGXPageTableUpdateViewDelegate.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CGXPageTableBaseView;

@protocol CGXPageTableUpdateViewDelegate <NSObject>

@required

@optional

/*     展示cell
 cell:每个cell
 model:每个cell的数据
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView Cell:(UITableViewCell *)cell  cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 展示头分区数据
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView HeaderView:(UITableViewHeaderFooterView *)headerView  HeaderInSection:(NSInteger)section;
/*
 展示脚分区数据
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView FooterView:(UITableViewHeaderFooterView *)footerView  FooterInSection:(NSInteger)section;
/*
 点击cell
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  TapInHeaderSection:(NSInteger)section;

- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  TapInFooterSection:(NSInteger)section;


@end

NS_ASSUME_NONNULL_END
