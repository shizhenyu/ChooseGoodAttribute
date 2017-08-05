//
//  ZYFilterCell.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYFilterModel;

@interface ZYFilterCell : UIView

/** button的宽度 */
@property (nonatomic,assign) NSInteger buttonWidth;

/** button的高度 */
@property (nonatomic,assign) NSInteger buttonHeight;
@property (nonatomic,assign) NSInteger paddingHorizontal;
@property (nonatomic,assign) NSInteger paddingVertical;
@property (nonatomic,assign) NSInteger paddingBottom;
@property (nonatomic,assign) CGFloat maxViewWidth;
@property (nonatomic,strong) UIColor *buttonNormalColor;
@property (nonatomic,strong) UIColor *buttonTitleColor;
@property (nonatomic,strong) UIColor *buttonHighlightColor;

/** button正常状态下的边角颜色 */
@property (nonatomic,strong) UIColor *buttonNormalBorderColor;

/** button选中状态下的边角颜色 */
@property (nonatomic,strong) UIColor *buttonSelectBorderColor;

/** button选中状态下的背景颜色 */
@property (nonatomic,strong) UIColor *buttonSelectBackGroundColor;

/** button正常状态下的背景颜色 */
@property (nonatomic,strong) UIColor *buttonNormalBackGroundColor;

- (instancetype)init:(ZYFilterModel *) model Width:(CGFloat) width;

- (CGFloat)getEstimatedHeight;
- (void)setSelectedChoice:(NSString *)choice;
- (NSArray *)getSelectedValues;

@end
