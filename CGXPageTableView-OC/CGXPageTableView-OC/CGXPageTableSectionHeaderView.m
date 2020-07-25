//
//  CGXPageTableSectionHeaderView.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/25.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageTableSectionHeaderView.h"

@implementation CGXPageTableSectionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
            self.titleLabel  =[[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.layer.borderWidth = 0;
        self.titleLabel.layer.borderColor = [UIColor colorWithWhite:0.93 alpha:1].CGColor;
        self.titleLabel.layer.cornerRadius = 4;
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self updateKit:self.titleLabel];
    }
    return self;
}
- (void)updateKit:(UIView *)view
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:top];
    [self.contentView addConstraint:left];
    [self.contentView addConstraint:right];
    [self.contentView addConstraint:bottom];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateKit:self.titleLabel];
}

- (void)updateWithCGXPageTableHeaderViewModel:(CGXPageTableBaseSectionModel *)model InSection:(NSInteger)section
{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)section];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
