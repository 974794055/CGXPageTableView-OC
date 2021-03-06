//
//  ViewController.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CGXPageTableUpdateViewDelegate,CGXPageTableGeneralViewDataDelegate>

@property(nonatomic , strong) CGXPageTableGeneralView *generalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.edgesForExtendedLayout = UIRectEdgeNone;
    self.generalView = [[CGXPageTableGeneralView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-83)];
    self.generalView.viewDelegate = self;
    self.generalView.dataDelegate = self;
    [self.generalView registerCell:[CGXPageTableTextCell class] IsXib:NO];
    [self.view addSubview:self.generalView];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        CGXPageTableGeneralSectionModel *sectionModel = [[CGXPageTableGeneralSectionModel alloc] init];
        
        CGXPageTableHeaderModel *headerModel = [[CGXPageTableHeaderModel alloc] initWithHeaderClass:[CGXPageTableSectionHeaderView class] IsXib:NO];
        headerModel.headerHeight= 40;
        headerModel.headerBgColor  = [UIColor orangeColor];
        sectionModel.headerModel = headerModel;
        
        CGXPageTableFooterModel *footerModel = [[CGXPageTableFooterModel alloc] initWithFooterClass:[CGXPageTableSectionFooterView class] IsXib:NO];
        footerModel.footerHeight= 40;
        footerModel.footerBgColor  = [UIColor redColor];
        sectionModel.footerModel = footerModel;
        
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j<arc4random() % 10+3; j++) {
            CGXPageTableGeneralRowModel *item = [[CGXPageTableGeneralRowModel alloc] initWithCellClass:[CGXPageTableTextCell class] IsXib:NO];
            item.cellHeight = 100;
            item.cellColor = RandomColor;
            
            NSMutableArray *actionArray = [NSMutableArray array];
            NSMutableArray *actionA = [NSMutableArray arrayWithObjects:@"删除",@"编辑", nil];
            for (int k = 0; k<actionA.count; k++) {
                CGXPageTableEditActionModel *actionModel = [[CGXPageTableEditActionModel alloc] init];
                actionModel.itemTitle = actionA[k];
                [actionArray addObject:actionModel];
            }
            item.editArray = actionArray;
            if (j==0) {
                item.isEdit =  YES;
            } else{
                 item.isEdit = NO;
            }
            
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
    NSLog(@"TapInHeaderSection：%ld" ,section);
}

- (void)gx_PageTableBaseView:(CGXPageTableBaseView *)generalView  TapInFooterSection:(NSInteger)section
{
    NSLog(@"TapInFooterSection：%ld" ,section);
}
/*
 左滑cell时按钮处理事件
 */
- (void)gx_PageTableGeneralView:(CGXPageTableGeneralView *)generalView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath RowModel:(nonnull CGXPageTableGeneralRowModel *)rowModel
{
    NSLog(@"editActionsForRowAtIndexPath：%@" ,indexPath);
}

@end
