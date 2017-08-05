//
//  ZYFilterView.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "ZYFilterView.h"
#import "GoodAttributeMacro.h"

#import "ZYFilterMacro.h"
#import "ZYFilterCell.h"
#import "UIButton+ZYKit.h"

@interface ZYFilterView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *pickTableView;

@property (nonatomic,strong) NSArray *pickerChoices;

@property (nonatomic,strong) ZYFilterModel *selectingModel;

@property (nonatomic,assign) CGFloat defaultPickerViewHeight;

@property (nonatomic, strong) UIView *footerView;

/** 购买数量Lbl */
@property (nonatomic, weak) UILabel *buyNumsLbl;

@end

@implementation ZYFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.defaultPickerViewHeight = 100;
        
        self.filterModels = @[];
        self.pickerChoices = @[];
        
        // 创建tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];//不用自定义style，需要设置背景
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
        
        // 创建表尾的 购买数量的 view
        self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 70)];
        
        UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(kSmallMargin, 0, 80, kBigMargin)];
        [numLab setText:@"购买数量"];
        numLab.font=kContentTextFont;
        numLab.textColor=HX_RGB(136, 137, 138);
        [self.footerView addSubview:numLab];
        
        UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [minusBtn setTitle:@"-" forState:UIControlStateNormal];
        CGFloat minusBtnWH = 35;
        CGFloat minusBtnX = kBigMargin;
        CGFloat minusBtnY = CGRectGetMaxY(numLab.frame)+15;
        minusBtn.frame = CGRectMake(minusBtnX, minusBtnY, minusBtnWH, minusBtnWH);
        [minusBtn defaultStyleWithNormalTitleColor:[UIColor blackColor] andHighTitleColor:HX_RGB(125, 125, 125) andBorderColor:LXBorderColor andBackgroundColor:HX_RGB(250, 250, 250) andHighBgColor:HX_RGB(220, 220, 220) withcornerRadius:1];
        [minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:minusBtn];
        
        // count
        UILabel *buyNumsLbl = [[UILabel alloc] init];
        
        buyNumsLbl.text = [NSString stringWithFormat:@"%d", self.buyNum];
        
        buyNumsLbl.textAlignment = NSTextAlignmentCenter;
        
        buyNumsLbl.layer.borderWidth = 1;
        
        buyNumsLbl.layer.borderColor = LXBorderColor.CGColor;
        
        CGFloat buyNumsLblW = minusBtnWH * 2;
        
        CGFloat buyNumsLblH = minusBtnWH;
        
        CGFloat buyNumsLblX = CGRectGetMaxX(minusBtn.frame) - 1;
        CGFloat buyNumsLblY = minusBtnY;
        buyNumsLbl.frame = CGRectMake(buyNumsLblX, buyNumsLblY, buyNumsLblW, buyNumsLblH);
        [self.footerView addSubview:buyNumsLbl];
        self.buyNumsLbl = buyNumsLbl;
        
        // +
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setTitle:@"+" forState:UIControlStateNormal];
        CGFloat plusBtnWH = 35;
        CGFloat plusBtnX = CGRectGetMaxX(buyNumsLbl.frame);
        CGFloat plusBtnY = minusBtnY;
        plusBtn.frame = CGRectMake(plusBtnX, plusBtnY, plusBtnWH, plusBtnWH);
        [plusBtn defaultStyleWithNormalTitleColor:[UIColor blackColor] andHighTitleColor:HX_RGB(125, 125, 125) andBorderColor:LXBorderColor andBackgroundColor:HX_RGB(250, 250, 250) andHighBgColor:HX_RGB(220, 220, 220) withcornerRadius:1];
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:plusBtn];
        
        _tableView.tableFooterView = self.footerView;
        
        _tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        self.backgroundColor =[UIColor whiteColor];
        

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(filterButtonClicked:)
                                                     name:ZY_NOTIFICATION_BUTTON_CLICKED object:nil];
    }
    
    return self;
}

#pragma mark - Remove Notofication
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 重新布局
- (void)layoutSubviews{
    
    [_tableView reloadData];
    
}

- (void)filterButtonClicked:(NSNotification*)notification{
    
    ZYFilterModel *filterModel = [notification.object objectForKey:@"data"];
    
    NSString *selectedTag = [notification.object objectForKey:@"selectIndex"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickAtModel:selectIndex:)]) {
        
        [self.delegate didClickAtModel:filterModel selectIndex:selectedTag];
        
    }
    
}



#pragma mark - tableView delegate && DataSource

#pragma mark - tableView  多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.filterModels.count;

}

#pragma mark - tableView 多少个行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}

#pragma mark - Cell For Row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYFilterModel *model = self.filterModels[indexPath.section];
    
    CGFloat width  = CGRectGetWidth(self.frame);
    
    if (!model.cachedView || CGRectGetWidth(model.cachedView.frame) != width) {
        
        model.cachedView = [model getCustomViewOfWdith:width];
        
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"filterdatacell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:model.cachedView];
    
    return cell;
    
}

#pragma mark - Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        ZYFilterModel *model = self.filterModels[indexPath.section];
        
        CGFloat width  = CGRectGetWidth(self.frame);
        
        if (!model.cachedView) {
            
            model.cachedView = [model getCustomViewOfWdith:width];
            
        }
        
        ZYFilterCell *selectView = (ZYFilterCell *)model.cachedView;
        
        if (selectView.maxViewWidth != width) {
            
            model.cachedView = [model getCustomViewOfWdith:width];
            
            selectView = (ZYFilterCell *)model.cachedView;
            
        }
        
        return [selectView getEstimatedHeight];
    
}

#pragma mark - tableView  区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCustomSectionHeaderHeight)]) {
            
        return [self.delegate getCustomSectionHeaderHeight];
            
    }else{
            
        return 30;
            
    }
    
}

#pragma mark - tableView  区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        
        if (self.delegate && [self.delegate respondsToSelector:
                              @selector(getCustomSectionHeaderHeight)]) {
            
            return [self.delegate getCustomSectionHeaderHeight];
            
        }else{
            
            return 20;
            
        }
    
}


#pragma mark - table 的区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        
        ZYFilterModel *model = self.filterModels[section];
        
        if (self.delegate && [self.delegate respondsToSelector:
                              @selector(getCustomSectionHeader)]) {
            
            ZYFilterSectionHeaderView *header = [self.delegate getCustomSectionHeader];
            
            [header setSectionHeaderTitle:model.title];
            
            return header;
        }
        
        CGFloat width = CGRectGetWidth(self.frame);
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
        
        bg.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, width, 21)];
        
        titleLabel.textColor = RGBCOLOR(136, 137, 138);
    
        titleLabel.text = model.title;
        
        [bg addSubview:titleLabel];
        
        
        return bg;
}

#pragma mark - table 的区尾
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width , 20)];
    
    foot.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, 10, width-20, 1)];
    
    lineView.backgroundColor =[UIColor lightGrayColor];
    
    [foot addSubview:lineView];
    
    return foot;
    
}

#pragma mark - tableView  选中某行的代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        CGFloat sectionHeaderHeight = 30;
        
        if (self.delegate && [self.delegate respondsToSelector:
                              @selector(getCustomSectionHeaderHeight)]) {
            
            sectionHeaderHeight = [self.delegate getCustomSectionHeaderHeight];
            
        }
        
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=-20) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            
        }
    }
}

- (void)setFilterModels:(NSArray *)models{
    
    [models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ZYFilterModel *model = (ZYFilterModel *)obj;
        
        model.tag = idx;
    }];
    
    _filterModels = models;
    
    [self.tableView reloadData];
    
}


#pragma mark - Select Product Count
- (void)minusBtnClick {
    
    if (self.buyNum == 1) return;
    
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d", --self.buyNum];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dicChangeProductCount:)]) {
        
        [self.delegate dicChangeProductCount:self.buyNum];
        
    }
}

- (void)plusBtnClick {
    
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d", ++self.buyNum];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dicChangeProductCount:)]) {
        
        [self.delegate dicChangeProductCount:self.buyNum];
        
    }
    
}

#pragma mark - Setter && Getter

- (int)buyNum
{
    if (!_buyNum) {
        
        self.buyNum = 1;
        
    }
    
    return _buyNum;
}


- (void)setSelectAttributeArr:(NSMutableArray *)selectAttributeArr {
    
    for (int i = 0; i < selectAttributeArr.count; i ++) {
        
        NSString *selectedStr = [selectAttributeArr objectAtIndex:i];
        
        NSInteger selecedtSection = [[[selectedStr componentsSeparatedByString:@"-"] objectAtIndex:1] integerValue];
        
        NSInteger selecedtRow = [[[selectedStr componentsSeparatedByString:@"-"] objectAtIndex:2] integerValue];
        
        ZYFilterModel *mainModel = [self.filterModels objectAtIndex:selecedtSection];
        
        ZYFilterCell *cell = (ZYFilterCell *)mainModel.cachedView;
        
        NSString *subAttributeStr = [mainModel.elements objectAtIndex:selecedtRow];
        
        [cell setSelectedChoice:subAttributeStr];
        
    }
    
}

- (void)setLastBuyCount:(int)lastBuyCount {
    
    self.buyNum = lastBuyCount;
    
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d",lastBuyCount];
}



@end
