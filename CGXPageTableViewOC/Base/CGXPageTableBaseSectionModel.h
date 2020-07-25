//
//  CGXPageTableBaseSectionModel.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXPageTableFooterModel.h"
#import "CGXPageTableHeaderModel.h"
#import "CGXPageTableBaseRowModel.h"
#import "CGXPageTableEditActionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageTableBaseSectionModel : NSObject
- (void)initializeData NS_REQUIRES_SUPER;

/*
 头分区
 */
@property (nonatomic , strong) CGXPageTableHeaderModel *headerModel;
/*
 脚分区
 */
@property (nonatomic , strong) CGXPageTableFooterModel *footerModel;


@property (nonatomic,strong) NSMutableArray<CGXPageTableBaseRowModel *> *rowArray;

@property (nonatomic , strong) id dataModel;//原始数据

@end

NS_ASSUME_NONNULL_END
