//
//  UIButton+CGXPageTableBlock.h
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (CGXPageTableBlock)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addTapBlock:(void(^)(UIButton*btn))block;

@end

NS_ASSUME_NONNULL_END
