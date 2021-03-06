//
//  UIButton+CGXPageTableBlock.m
//  CGXPageTableView-OC
//
//  Created by CGX on 2020/7/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIButton+CGXPageTableBlock.h"
#import <objc/runtime.h>

@implementation UIButton (CGXPageTableBlock)

-(void)setBlock:(void(^)(UIButton*))block{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}
-(void(^)(UIButton*))block{
    return objc_getAssociatedObject(self,@selector(block));
    
}
-(void)addTapBlock:(void(^)(UIButton*))block{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click:(UIButton*)btn{
    if(self.block){
        self.block(btn);
    }
}



@end
