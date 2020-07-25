//
//  CGXPageTableBaseSectionModel.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableBaseSectionModel.h"

@interface CGXPageTableBaseSectionModel()

//默认不适用xib
@property (nonatomic , assign,readwrite) BOOL isXib;
@property(nonatomic, strong,readwrite) Class cellClass;

@end
@implementation CGXPageTableBaseSectionModel
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}
- (void)initializeData
{
    self.rowArray = [NSMutableArray array];
    self.headerModel = [[CGXPageTableHeaderModel alloc] initWithHeaderClass:[UITableViewHeaderFooterView class] IsXib:NO];
    self.footerModel = [[CGXPageTableFooterModel alloc] initWithFooterClass:[UITableViewHeaderFooterView class] IsXib:NO];
}
@end
