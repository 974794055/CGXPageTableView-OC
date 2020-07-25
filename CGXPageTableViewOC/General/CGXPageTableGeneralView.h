//
//  CGXPageTableGeneralView.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableBaseView.h"
#import "CGXPageTableGeneralSectionModel.h"
#import "CGXPageTableGeneralRowModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXPageTableGeneralView;
@protocol CGXPageTableGeneralViewDataDelegate <NSObject>

@required

@optional

/*
 左滑cell时按钮处理事件
 */
- (void)gx_PageTableGeneralView:(CGXPageTableGeneralView *)generalView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath RowModel:(CGXPageTableGeneralRowModel *)rowModel;

@end

@interface CGXPageTableGeneralView : CGXPageTableBaseView

@property (nonatomic , weak) id<CGXPageTableGeneralViewDataDelegate>dataDelegate;


- (void)deleteRowsWithEditAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteRowsWithEditAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)replaceSectionAtAtIndexPath:(NSInteger)section SectionModel:(CGXPageTableGeneralSectionModel *)sectionModel;
- (void)replaceRowAtAtIndexPath:(NSIndexPath *)indexPath RowModel:(CGXPageTableGeneralRowModel *)rowModel;

@end

NS_ASSUME_NONNULL_END
