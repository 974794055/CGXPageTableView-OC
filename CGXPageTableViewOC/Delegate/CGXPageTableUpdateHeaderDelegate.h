//
//  CGXPageTableUpdateHeaderDelegate.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CGXPageTableBaseSectionModel;
@protocol CGXPageTableUpdateHeaderDelegate <NSObject>
@required

@optional
- (void)updateWithCGXPageTableHeaderViewModel:(CGXPageTableBaseSectionModel *)model InSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
