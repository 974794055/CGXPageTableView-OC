//
//  CGXPageTableGeneralRowModel.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableBaseRowModel.h"
#import "CGXPageTableEditActionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageTableGeneralRowModel : CGXPageTableBaseRowModel

@property (nonatomic , strong) NSMutableArray<CGXPageTableEditActionModel *> *editArray;
@property (nonatomic , assign) BOOL isEdit;
@property (nonatomic , assign) UITableViewCellEditingStyle style;
@end

NS_ASSUME_NONNULL_END
