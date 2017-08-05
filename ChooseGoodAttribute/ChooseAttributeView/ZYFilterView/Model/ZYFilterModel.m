//
//  ZYFilterModel.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "ZYFilterModel.h"
#import "ZYFilterCell.h"
#import "ZYFilterMacro.h"

@implementation ZYFilterModel

- (instancetype)initWithElement:(NSArray *)array {
    
    self = [super init];
    
    if (self) {
        
        _elements = array;
        
        self.style = ZYFilterViewDefault;
        
    }
    
    return self;
}

- (UIView *)getCustomViewOfWdith:(CGFloat)width {
    
    ZYFilterCell *filterCell = [[ZYFilterCell alloc]init:self Width:width];
    
    if (self.style == ZYFilterViewDefault) {
        
    }else if (self.style == ZYFilterViewStyle1) {
        
        filterCell.buttonNormalColor = ZY_HL_COLOR;
        
        filterCell.buttonHighlightColor = ZY_HL_COLOR;
    }
    
    return filterCell;
}

- (NSArray *)getFilterResult {
    
    if (self.cachedView && [self.cachedView isKindOfClass:[ZYFilterCell class]]) {
        
        ZYFilterCell *cellView = (ZYFilterCell *)self.cachedView;
        
        return [cellView getSelectedValues];
        
    }
    
    return @[];
}

@end
