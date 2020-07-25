//
//  CGXPageTableBaseView.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageTableBaseSectionModel.h"

/**********       Delegate       **********/
#import "CGXPageTableUpdateCellDelegate.h"
#import "CGXPageTableUpdateHeaderDelegate.h"
#import "CGXPageTableUpdateFooterDelegate.h"
#import "CGXPageTableUpdateViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXPageTableBaseView;
/*
  刷 新。
 */
typedef void (^CGXPageTableBaseViewRefresBlock)(CGXPageTableBaseView *baseView,BOOL isDownRefresh,NSInteger page);
/*
 刷 新 更新界面 停止刷新
 pageInter :每页数量
 pageMax:每页最大数量
 */
typedef void (^CGXPageTableBaseViewRefresEndBlock)(CGXPageTableBaseView *baseView,NSInteger pageInter,NSInteger pageMax);

/*
 自适应返回的高度
 */
typedef void (^CGXPageTableBaseViewHeightBlock)(CGXPageTableBaseView *baseView,CGFloat height);

@interface CGXPageTableBaseView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic,strong,readonly) NSMutableArray<CGXPageTableBaseSectionModel *> *dataArray;


/*
  刷新回调
 */
@property (nonatomic , copy) CGXPageTableBaseViewRefresBlock refresBlock;
/*
 刷新状态回调
*/
@property (nonatomic , copy) CGXPageTableBaseViewRefresEndBlock refresEndBlock;
/*
 界面设置代理
*/
@property (nonatomic , weak) id<CGXPageTableUpdateViewDelegate>viewDelegate;
/*
 自适应高度
*/
@property (nonatomic , copy) CGXPageTableBaseViewHeightBlock heightBlock;


- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib;

- (void)refreshSectionModel:(CGXPageTableBaseSectionModel *)baseSectionModel NS_REQUIRES_SUPER;

#pragma mark - Subclass Override 子类调用
- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

#pragma mark - 数据处理
/*
 加载数据 下拉调用
 */
- (void)loadData;
/*
 加载更多数据 上拉调用
 */
- (void)loadMoreData;
/*
 array：数据源
 page:每次加载的个数
 maxPage:每页返回最大值 默认20
 */
- (void)updateDataArray:(NSMutableArray<CGXPageTableBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page;
- (void)updateDataArray:(NSMutableArray<CGXPageTableBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page MaxPage:(NSInteger)maxPage;


@end

NS_ASSUME_NONNULL_END
