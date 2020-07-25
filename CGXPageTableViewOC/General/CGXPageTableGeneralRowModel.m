//
//  CGXPageTableGeneralRowModel.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableGeneralRowModel.h"

@implementation CGXPageTableGeneralRowModel

- (void)initializeData
{
    [super initializeData];
    self.editArray = [NSMutableArray array];
    self.style = UITableViewCellEditingStyleNone;
    self.isEdit = NO;
}
@end
