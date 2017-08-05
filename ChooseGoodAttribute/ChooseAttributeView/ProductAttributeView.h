//
//  ProductAttributeView.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductAttributeView : UIView

@property (nonatomic, copy) NSString *good_img;
@property (nonatomic, copy) NSString *good_name;
@property (nonatomic, copy) NSString *good_price;

/**  商品选中属性的回调 */
@property (nonatomic, copy) void (^rememberBtnsClick)(NSString *num, CGFloat totalPrice, NSMutableArray *selectedAttributeArr);

/** 购买数量 */
@property (nonatomic, assign) int buyNum;

/**
 * 初始化方法，传进去商品属性arr
 */
- (instancetype)initWithFrame:(CGRect)frame withGoodAttributeArr:(NSMutableArray *)arr;

/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;

/**
 *  属性视图的消失
 */
- (void)removeView;


/**
 *  用来记录上一次选中的商品属性（由外部界面传入） 用来显示上一次选中商品的属性
 */
- (void)lastSelectedAttributeArr:(NSMutableArray *)arr  buyCount:(int)count;

@end
