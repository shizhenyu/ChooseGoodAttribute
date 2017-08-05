//
//  ZYFilterSectionHeaderView.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "ZYFilterSectionHeaderView.h"

@implementation ZYFilterSectionHeaderView

- (void)setSectionHeaderTitle:(NSString *)title{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil];
}

@end
