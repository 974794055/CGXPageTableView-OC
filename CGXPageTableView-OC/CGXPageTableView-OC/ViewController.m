//
//  ViewController.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CGXPageTableUpdateViewDelegate>

@property(nonatomic , strong) CGXPageTableGeneralView *generalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.edgesForExtendedLayout = UIRectEdgeNone;
    self.generalView = [[CGXPageTableGeneralView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-83)];
    self.generalView.viewDelegate = self;
    [self.view addSubview:self.generalView];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        CGXPageTableGeneralSectionModel *sectionModel = [[CGXPageTableGeneralSectionModel alloc] init];
        
        CGXPageTableHeaderModel *headerModel = [[CGXPageTableHeaderModel alloc] initWithHeaderClass:[UITableViewHeaderFooterView class] IsXib:NO];
        headerModel.headerHeight= 40;
        headerModel.headerBgColor  = [UIColor orangeColor];
        sectionModel.headerModel = headerModel;
        
        CGXPageTableFooterModel *footerModel = [[CGXPageTableFooterModel alloc] initWithFooterClass:[UITableViewHeaderFooterView class] IsXib:NO];
        footerModel.footerHeight= 40;
        footerModel.footerBgColor  = [UIColor colorWithWhite:0.93 alpha:1];
        sectionModel.footerModel = footerModel;
        
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int i = 0; i<arc4random() % 10+3; i++) {
            CGXPageTableGeneralRowModel *item = [[CGXPageTableGeneralRowModel alloc] initWithCellClass:[UITableViewCell class] IsXib:NO];
            item.cellHeight = 100;
            item.cellColor = RandomColor;
            [rowArray addObject:item];
        }
        sectionModel.rowArray = [NSMutableArray arrayWithArray:rowArray];
        [dataArray addObject:sectionModel];
    }
    [self.generalView updateDataArray:dataArray IsDownRefresh:YES Page:1];
    
}
/*     展示cell
 cell:每个cell
 model:每个cell的数据
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView Cell:(UITableViewCell *)cell  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"展示cell:indexPath：%@" ,indexPath);
    //    NSLog(@"展示cell：\n%ld--%@" , generalView.dataArray.count,NSStringFromClass([cell class]));
}

/*
 展示头分区数据
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView HeaderView:(UITableViewHeaderFooterView *)headerView  HeaderInSection:(NSInteger)section
{
    NSLog(@"HeaderInSection：%@--%ld" ,headerView,section);
}
/*
 展示脚分区数据
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView FooterView:(UITableViewHeaderFooterView *)footerView  FooterInSection:(NSInteger)section
{
    NSLog(@"FooterInSection：%@--%ld" ,footerView,section);
}
/*
 点击cell
 */
- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath：%@" ,indexPath);
}

- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  TapInHeaderSection:(NSInteger)section
{
    
}

- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  TapInFooterSection:(NSInteger)section
{
    
}


@end
