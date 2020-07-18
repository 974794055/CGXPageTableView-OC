//
//  UIView+CGXPageTableTap.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXPageTableTap)<UIGestureRecognizerDelegate>

@property (nonatomic,assign) void(^block)(NSInteger tag);

- (void)addTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void(^)(NSInteger tag))block;
@end

NS_ASSUME_NONNULL_END
