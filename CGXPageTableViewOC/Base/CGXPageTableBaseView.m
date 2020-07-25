//
//  CGXPageTableBaseView.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableBaseView.h"

@interface CGXPageTableBaseView()

@property (nonatomic,strong,readwrite) NSMutableArray<CGXPageTableBaseSectionModel *> *dataArray;

@property (nonatomic , assign) BOOL isDownRefresh;
@property (nonatomic , assign) NSInteger page;
@end

@implementation CGXPageTableBaseView

- (void)dealloc
{
    if (self.tableView) {
        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            ((UIViewController *)next).automaticallyAdjustsScrollViewInsets = NO;
            break;
        }
        next = next.nextResponder;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //部分使用者为了适配不同的手机屏幕尺寸，CGXPageTableBaseView的宽高比要求保持一样，所以它的高度就会因为不同宽度的屏幕而不一样。计算出来的高度，有时候会是位数很长的浮点数，如果把这个高度设置给UICollectionView就会触发内部的一个错误。所以，为了规避这个问题，在这里对高度统一向下取整。
    //如果向下取整导致了你的页面异常，请自己重新设置CGXPageTableBaseView的高度，保证为整数即可。
    self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, floor(self.bounds.size.height));
    [self.tableView reloadData];
}
#pragma mark - Subclass Override 子类调用
- (void)initializeData
{
    self.dataArray = [NSMutableArray array];
    self.page = 1;
    self.isDownRefresh = YES;
}

- (void)initializeViews
{
    self.tableView = ({
        UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStyleGrouped];
        myTableView.dataSource = self;
        myTableView.delegate = self;
        [myTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        myTableView.estimatedRowHeight = 50;
        myTableView.backgroundColor = [UIColor whiteColor];
        myTableView.estimatedSectionFooterHeight  = 10;
        myTableView.estimatedSectionHeaderHeight = 10;
        [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
        if (@available(iOS 11.0, *)) {
            myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        myTableView;
    });
    [self addSubview:self.tableView];
}
- (void)hidekeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib
{
    if (![classCell isKindOfClass:[UITableViewCell class]]) {
        NSAssert(![classCell isKindOfClass:[UITableViewCell class]], @"注册cell的必须是UITableViewCell类型");
    }
    if (isXib) {
        [self.tableView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", classCell] bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
    } else{
         [self.tableView registerClass:classCell forCellReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
    }
}
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib
{
    if (![footer isKindOfClass:[UITableViewHeaderFooterView class]]) {
        NSAssert(![footer isKindOfClass:[UITableViewHeaderFooterView class]], @"注册foot的必须是UITableViewHeaderFooterView类型");
    }
    if (isXib) {
        [self.tableView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", footer] bundle:nil] forHeaderFooterViewReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    } else{
         [self.tableView registerClass:footer forHeaderFooterViewReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    }
}
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib
{
    if (![header isKindOfClass:[UITableViewHeaderFooterView class]]) {
        NSAssert(![header isKindOfClass:[UITableViewHeaderFooterView class]], @"注册header的必须是UITableViewHeaderFooterView类型");
    }
    if (isXib) {
        [self.tableView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", header] bundle:nil] forHeaderFooterViewReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    } else{
        [self.tableView registerClass:header forHeaderFooterViewReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    }
}

#pragma mark - 数据代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.rowArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.footerModel.footerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.headerModel.headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXPageTableBaseRowModel *itemModel = sectionModel.rowArray[indexPath.row];
    return itemModel.cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[section];
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.headerModel.headerIdentifier];
    if (headerView == nil) {
        headerView = [[NSClassFromString(sectionModel.headerModel.headerIdentifier) alloc] initWithReuseIdentifier:sectionModel.headerModel.headerIdentifier];
    }
    headerView.contentView.backgroundColor = sectionModel.headerModel.headerBgColor;
    BOOL isHave = [headerView respondsToSelector:@selector(updateWithCGXPageTableHeaderViewModel:InSection:)];
    if (isHave && [headerView conformsToProtocol:@protocol(CGXPageTableUpdateHeaderDelegate)]) {
        [(UITableViewHeaderFooterView<CGXPageTableUpdateHeaderDelegate> *)headerView updateWithCGXPageTableHeaderViewModel:sectionModel  InSection:section];
    }
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageTableBaseView:HeaderView:HeaderInSection:)]) {
        [self.viewDelegate gx_PageTableBaseView:self HeaderView:headerView HeaderInSection:section];
    }
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[section];
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.footerModel.footerIdentifier];
    if (footerView == nil) {
        footerView = [[NSClassFromString(sectionModel.footerModel.footerIdentifier) alloc] initWithReuseIdentifier:sectionModel.footerModel.footerIdentifier];
    }
    footerView.contentView.backgroundColor = sectionModel.footerModel.footerBgColor;
    BOOL isHave = [footerView respondsToSelector:@selector(updateWithCGXPageTableFooterViewModel:InSection:)];
    if (isHave && [footerView conformsToProtocol:@protocol(CGXPageTableUpdateFooterDelegate)]) {
        [(UITableViewHeaderFooterView<CGXPageTableUpdateFooterDelegate> *)footerView updateWithCGXPageTableFooterViewModel:sectionModel  InSection:section];
    }
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageTableBaseView:FooterView:FooterInSection:)]) {
        [self.viewDelegate gx_PageTableBaseView:self FooterView:footerView FooterInSection:section];
    }
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageTableBaseSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXPageTableBaseRowModel *itemModel = sectionModel.rowArray[indexPath.row];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:itemModel.cellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = itemModel.cellColor;
    BOOL isHave = [cell respondsToSelector:@selector(updateWithCGXPageTableCellModel:AtIndex:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXPageTableUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXPageTableUpdateCellDelegate> *)cell updateWithCGXPageTableCellModel:itemModel  AtIndex:indexPath.row];
    }
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageTableBaseView:Cell:cellForRowAtIndexPath:)]) {
        [self.viewDelegate gx_PageTableBaseView:self Cell:cell cellForRowAtIndexPath:indexPath];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 给外界提供实现方法
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageTableBaseView:didSelectRowAtIndexPath:)]) {
        [self.viewDelegate gx_PageTableBaseView:self didSelectRowAtIndexPath:indexPath];
    }
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//    cell.separatorInset = UIEdgeInsetsZero;
//    cell.layoutMargins = UIEdgeInsetsZero;
//    cell.preservesSuperviewLayoutMargins = NO;
//}

#pragma mark - 数据处理
/*
 加载数据 下拉调用
 */
- (void)loadData
{
    self.isDownRefresh = YES;
      self.page = 1;
      if (self.refresBlock) {
          self.refresBlock(self, self.isDownRefresh, self.page);
      }
}
/*
 加载更多数据 上拉调用
 */
- (void)loadMoreData
{
    self.isDownRefresh = NO;
    self.page++;
    if (self.refresBlock) {
        self.refresBlock(self,self.isDownRefresh, self.page);
    }
}
/*
 array：数据源
 pageCount:每次加载的个数
 pageSize：每页个数。默认10个
 maxPage:每页返回最大值 默认20
 */
- (void)updateDataArray:(NSMutableArray<CGXPageTableBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page
{
    [self updateDataArray:array IsDownRefresh:isDownRefresh Page:page MaxPage:20];
}
- (void)updateDataArray:(NSMutableArray<CGXPageTableBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page MaxPage:(NSInteger)maxPage
{
    self.page = page;
    self.isDownRefresh = isDownRefresh;
    if (isDownRefresh) {
        [self.dataArray removeAllObjects];
    }
    for (CGXPageTableBaseSectionModel *sectionModel in array) {
        [self refreshSectionModel:sectionModel];
        [self.dataArray addObject:sectionModel];
    }
    [self.tableView reloadData];
    if (self.refresBlock) {
        self.refresBlock(self, array.count, maxPage);
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)refreshSectionModel:(CGXPageTableBaseSectionModel *)baseSectionModel
{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
