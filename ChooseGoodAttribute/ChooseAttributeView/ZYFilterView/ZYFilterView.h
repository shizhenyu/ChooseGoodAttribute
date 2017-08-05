//
//  ZYFilterView.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYFilterSectionHeaderView.h"
#import "ZYFilterMacro.h"
#import "ZYFilterModel.h"

@protocol ZYFilterViewDelegate <NSObject>

@optional
- (NSInteger)getCustomSectionHeaderHeight;
- (ZYFilterSectionHeaderView *)getCustomSectionHeader;

- (void)didClickAtModel:(ZYFilterModel *)data selectIndex:(NSString *)selectTag;

- (void)dicChangeProductCount:(int)productCount;

@end

@interface ZYFilterView : UIView

@property (nonatomic,strong) NSArray *filterModels;

@property (nonatomic,weak) id<ZYFilterViewDelegate> delegate;

/** 购买数量 */
@property (nonatomic, assign) int buyNum;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *selectAttributeArr;

@property (nonatomic, assign) int lastBuyCount;

@end
