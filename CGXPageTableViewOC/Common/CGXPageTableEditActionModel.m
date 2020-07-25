//
//  CGXPageTableEditActionModel.m
//  CGXPageTableViewOC
//
//  Created by CGX on 2020/7/25.
//

#import "CGXPageTableEditActionModel.h"

@implementation CGXPageTableEditActionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemColor = [UIColor redColor];
        self.itemFont = [UIFont systemFontOfSize:14];
        self.itemColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    }
    return self;
}
@end
