//
//  SelectBtn.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelBtn.h"

@interface SelectBtn : NSObject

@property (nonatomic, strong) ModelBtn *modelBtn;

+ (instancetype)sharedManager;

@end
