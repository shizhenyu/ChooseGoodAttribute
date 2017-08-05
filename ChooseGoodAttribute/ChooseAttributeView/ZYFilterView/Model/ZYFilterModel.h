//
//  ZYFilterModel.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 枚举  设置FilterView的样式
typedef NS_ENUM(NSInteger, ZYFilterViewStyle) {
    
    ZYFilterViewDefault,ZYFilterViewStyle1
    
};

@interface ZYFilterModel : NSObject

/** 次级属性选择Arr（为了保证数据安全性，设置只读属性） */
@property (nonatomic, strong, readonly) NSArray *elements;

/** 上一次就选中的属性 */
@property (nonatomic, strong) NSArray *choices;

@property (nonatomic, strong) UIView *cachedView;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSDictionary *originData;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) ZYFilterViewStyle style;

@property (nonatomic, copy) NSString *clickedButtonText;

/** 传进属性array初始化 */
- (instancetype)initWithElement:(NSArray *)array;

/** 获取CellView */
- (UIView *)getCustomViewOfWdith:(CGFloat)width;

- (NSArray *)getFilterResult;

@end
