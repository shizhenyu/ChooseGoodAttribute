//
//  SelectBtn.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "SelectBtn.h"

@implementation SelectBtn

+ (instancetype)sharedManager {
    
    static SelectBtn *share_selectBtn = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        share_selectBtn = [[self alloc]init];
        
        share_selectBtn.modelBtn = [[ModelBtn alloc]init];
        
    });
    
    return share_selectBtn;
}

@end
