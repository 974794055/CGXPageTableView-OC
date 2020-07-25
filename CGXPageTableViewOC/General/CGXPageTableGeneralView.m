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
                if (weakSelf.viewDelegate && [weakSelf.viewDelegate respondsToSelector:@selector(gx_PageTableBaseView:editActionsForRowAtIndexPath:)]) {
                    [weakSelf.viewDelegate gx_PageTableBaseView:self editActionsForRowAtIndexPath:indexPath];
                }
            }];
        } else{
            action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:actionModel.itemTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                [tableView setEditing:NO animated:NO];
                if (weakSelf.viewDelegate && [weakSelf.viewDelegate respondsToSelector:@selector(gx_PageTableBaseView:editActionsForRowAtIndexPath:)]) {
                    [weakSelf.viewDelegate gx_PageTableBaseView:self editActionsForRowAtIndexPath:indexPath];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
