//
//  CGXPageTableGeneralView.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableGeneralView.h"

@implementation CGXPageTableGeneralView


- (void)initializeData
{
    [super initializeData];
}

- (void)initializeViews
{
    [super initializeViews];
}

- (void)refreshSectionModel:(CGXPageTableBaseSectionModel *)baseSectionModel
{
    [super refreshSectionModel:baseSectionModel];
    if (baseSectionModel) {
           NSAssert([baseSectionModel isKindOfClass:[CGXPageTableGeneralSectionModel class]], @"数据源类型不对，必须是CGXPageTableGeneralSectionModel");
           if (baseSectionModel.rowArray.count>0) {
               NSAssert([[baseSectionModel.rowArray firstObject] isKindOfClass:[CGXPageTableGeneralRowModel class]], @"数据源类型不对，必须是CGXPageTableGeneralRowModel");
           }
       }
}
/** * 只要实现了这个方法，左滑出现按钮的功能就有了 (一旦左滑出现了N个按钮，tableView就进入了编辑模式, tableView.editing = YES) */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"indexPath--%@" , indexPath);
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageTableGeneralSectionModel *sectionModel = (CGXPageTableGeneralSectionModel *)self.dataArray[indexPath.section];
    CGXPageTableGeneralRowModel *itemModel = (CGXPageTableGeneralRowModel *)sectionModel.rowArray[indexPath.row];
    if (itemModel.isEdit) {
        return itemModel.style;
    } else{
         return UITableViewCellEditingStyleNone;
    }
}
/** * 左滑cell时出现什么按钮 */
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageTableGeneralSectionModel *sectionModel = (CGXPageTableGeneralSectionModel *)self.dataArray[indexPath.section];
    CGXPageTableGeneralRowModel *itemModel = (CGXPageTableGeneralRowModel *)sectionModel.rowArray[indexPath.row];
    if (itemModel.isEdit) {
        NSAssert(itemModel.editArray.count>0, @"可以编辑时按钮必须保证至少一个");
    }
    __weak typeof(self) weakSelf = self;
    NSMutableArray *actionAry = [NSMutableArray array];
    for (CGXPageTableEditActionModel *actionModel in itemModel.editArray) {
        UITableViewRowAction *action = [[UITableViewRowAction alloc] init];
        action.backgroundColor = actionModel.itemBgColor;
        if ([actionModel.itemTitle isEqualToString:@"删除"] || [actionModel.itemTitle isEqualToString:@"delete"]|| [actionModel.itemTitle isEqualToString:@"Delete"]) {
            action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:actionModel.itemTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                [tableView setEditing:NO animated:NO];
                if (weakSelf.dataDelegate && [weakSelf.dataDelegate respondsToSelector:@selector(gx_PageTableGeneralView:editActionsForRowAtIndexPath:RowModel:)]) {
                    [weakSelf.dataDelegate gx_PageTableGeneralView:self editActionsForRowAtIndexPath:indexPath RowModel:itemModel];
                }
            }];
        } else{
            action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:actionModel.itemTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                [tableView setEditing:NO animated:NO];
                if (weakSelf.dataDelegate && [weakSelf.dataDelegate respondsToSelector:@selector(gx_PageTableGeneralView:editActionsForRowAtIndexPath:RowModel:)]) {
                    [weakSelf.dataDelegate gx_PageTableGeneralView:self editActionsForRowAtIndexPath:indexPath RowModel:itemModel];
                }
            }];
        }
        [actionAry addObject:action];
    }
    return actionAry;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageTableGeneralSectionModel *sectionModel = (CGXPageTableGeneralSectionModel *)self.dataArray[indexPath.section];
    CGXPageTableGeneralRowModel *itemModel = (CGXPageTableGeneralRowModel *)sectionModel.rowArray[indexPath.row];
    if (itemModel.isEdit) {
        return YES;
    }
    return NO;
}

- (void)deleteRowsWithEditAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteRowsWithEditAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
}
- (void)deleteRowsWithEditAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation
{
    [CATransaction begin];  // 监听动画结束回调
    [CATransaction setCompletionBlock:^{
        // 动画结束
        [self.tableView reloadData];
    }];
    [self.tableView beginUpdates];
    CGXPageTableGeneralSectionModel *sectionModel = (CGXPageTableGeneralSectionModel *)self.dataArray[indexPath.section];
    [sectionModel.rowArray removeObjectAtIndex:indexPath.row];
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionModel];
    [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]
                          withRowAnimation:animation];
    [self.tableView endUpdates];
    [CATransaction commit];
}
- (void)replaceSectionAtAtIndexPath:(NSInteger)section SectionModel:(CGXPageTableGeneralSectionModel *)sectionModel
{
    if (self.dataArray.count==0) {
        return;
    }
    if (section>=self.dataArray.count) {
        return;
    }
    [self.dataArray replaceObjectAtIndex:section withObject:sectionModel];
    [self.tableView reloadData];
}
- (void)replaceRowAtAtIndexPath:(NSIndexPath *)indexPath RowModel:(CGXPageTableGeneralRowModel *)rowModel
{
    if (self.dataArray.count==0) {
        return;
    }
    if (indexPath.section>=self.dataArray.count) {
        return;
    }
    CGXPageTableGeneralSectionModel *sectionModel = (CGXPageTableGeneralSectionModel *)self.dataArray[indexPath.section];
    if (sectionModel.rowArray.count==0) {
        return;
    }
    if (indexPath.row>=sectionModel.rowArray.count) {
        return;
    }
    if (rowModel) {
        [sectionModel.rowArray replaceObjectAtIndex:indexPath.row withObject:rowModel];
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionModel];
        [self.tableView reloadData];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
