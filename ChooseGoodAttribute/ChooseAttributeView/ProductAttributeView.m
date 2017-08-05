//
//  ProductAttributeView.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "ProductAttributeView.h"
#import "GoodAttributeMacro.h"

#import "ZYFilterView.h"
#import "ZYFilterMacro.h"

#import "GoodAttributeModel.h"

@interface ProductAttributeView ()<ZYFilterViewDelegate>

@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, weak) UIImageView *iconImgView;

@property (nonatomic, weak) UILabel *goodsNameLbl;

@property (nonatomic, weak) UILabel *goodsPriceLbl;

/** 购买数量Lbl */
@property (nonatomic, weak) UILabel *buyNumsLbl;

@property (nonatomic,strong) ZYFilterView *filterView;

@property (nonatomic,strong) ZYFilterModel *clickModel;

/** 商品属性array */
@property (nonatomic, strong) NSMutableArray *productAttributeArr;

/** 选中属性array */
@property (nonatomic, strong) NSMutableArray *selectedAttributeArr;


/**  商品总价（会随着选择属性而变化） */
@property (nonatomic, assign) float totalPrice;

/**  商品总价（外部传过来，不会变化，给予参考） */
@property (nonatomic, assign) float currentPrice;

@end

@implementation ProductAttributeView

- (instancetype)initWithFrame:(CGRect)frame withGoodAttributeArr:(NSMutableArray *)arr{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.productAttributeArr = [NSMutableArray array];
        
        self.productAttributeArr = arr;
        
        self.selectedAttributeArr = [NSMutableArray array];
        
        [self setUpBasicView];
        
        _totalPrice = 0.0;
        
        _currentPrice = 0.0;
        
    }
    
    return self;
}

#pragma mark - Init Basic View
- (void)setUpBasicView {
    
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    
    [self addGestureRecognizer:tapBackGesture];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - kATTR_VIEW_HEIGHT, kScreenW, kATTR_VIEW_HEIGHT)];
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    
    // 添加手势，遮盖整个视图的手势，
    UITapGestureRecognizer *contentViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    
    [contentView addGestureRecognizer:contentViewTapGesture];
    
    [self addSubview:contentView];
    
    self.contentView = contentView;
    
    
    UIView *iconBackView = [[UIView alloc] initWithFrame:(CGRect){10, -15, 90, 90}];
    iconBackView.backgroundColor = kWhiteColor;
    iconBackView.layer.borderColor = LXBorderColor.CGColor;
    iconBackView.layer.borderWidth = 1;
    iconBackView.layer.cornerRadius = 3;
    [contentView addSubview:iconBackView];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 80, 80}];
    [iconImgView setImage:[UIImage imageNamed:@"hdl"]];
    [iconBackView addSubview:iconImgView];
    self.iconImgView = iconImgView;
    
    UIButton *XBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    XBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
    [XBtn setBackgroundImage:[UIImage imageNamed:@"逆购网app产品说明选择颜色尺寸弹窗"] forState:UIControlStateNormal];
    [XBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:XBtn];
    
    UILabel *goodsNameLbl = [[UILabel alloc] init];
    goodsNameLbl.text = @"商品名字";
    goodsNameLbl.textColor = kMAINCOLOR;
    goodsNameLbl.font = [UIFont systemFontOfSize:15];
    CGFloat goodsNameLblX = CGRectGetMaxX(iconBackView.frame) + 10;
    CGFloat goodsNameLblY = XBtn.frame.origin.y;
    
    goodsNameLbl.frame = (CGRect){goodsNameLblX,goodsNameLblY,kScreenW - 100 - 20,20};
    
    [contentView addSubview:goodsNameLbl];
    self.goodsNameLbl = goodsNameLbl;
    
    UILabel *goodsPriceLbl = [[UILabel alloc] initWithFrame:(CGRect){goodsNameLbl.frame.origin.x, CGRectGetMaxY(goodsNameLbl.frame) + 10, 150, 20}];
    goodsPriceLbl.text = @"99元";
    goodsPriceLbl.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:goodsPriceLbl];
    self.goodsPriceLbl = goodsPriceLbl;
    
    
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    
    CGFloat buttonW = kScreenW * 0.5;
    
    CGFloat buttonH = 50;
    
    CGFloat buttonY = contentView.frame.size.height - 50;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.tag = i;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGBCOLOR(249, 125, 10);
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat buttonX = (buttonW * i);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [contentView addSubview:button];
    }
    
    NSMutableArray *goodAttributeArr = [NSMutableArray array];
    
    [self.productAttributeArr enumerateObjectsUsingBlock:^(GoodAttrModel  *mainAttributeModel, NSUInteger idx, BOOL * stop) {
        
        NSMutableArray *subAttributeArr = [NSMutableArray array];
        
        [mainAttributeModel.attr_value enumerateObjectsUsingBlock:^(GoodAttrValueModel *subAttributeModel, NSUInteger idx, BOOL * stop) {
            
            [subAttributeArr addObject:subAttributeModel.attr_value];
            
        }];
        
        ZYFilterModel *attributeModel = [[ZYFilterModel alloc]initWithElement:subAttributeArr];
        
        attributeModel.title = mainAttributeModel.attr_name;
        
        attributeModel.style = ZYFilterViewDefault;
        
        [goodAttributeArr addObject:attributeModel];
        
    }];
    
    self.filterView = [[ZYFilterView alloc] initWithFrame:(CGRect){0, CGRectGetMaxY(iconImgView.frame), kScreenW, contentView.frame.size.height - 50 - CGRectGetMaxY(iconImgView.frame) - 10}];
    
    self.filterView.delegate = self;
    
    [self.filterView setFilterModels:goodAttributeArr];
    
    [self.contentView addSubview:self.filterView];
    
    
}

#pragma mark - 根据已选商品的属性去让tableView去刷新数据
- (void)defaultGoodAttributeArr {
    
    if (self.selectedAttributeArr.count == 0) {
        
        // 如果商品的属性没有选中的，那么就默认选择第一个，然后去刷新
        NSMutableArray *tempArr = [NSMutableArray array];
        
        [self.productAttributeArr enumerateObjectsUsingBlock:^(GoodAttrModel *mainAttribute, NSUInteger idx, BOOL * stop) {
            
            
            NSString *sbStr = [NSString stringWithFormat:@"%@-%d-%d-%@",mainAttribute.attr_name,idx,0,@""];
            
            [tempArr addObject:sbStr];
            
        }];
        
        [self.filterView setSelectAttributeArr:tempArr];
        
        [self.filterView setLastBuyCount:1];
        
    }else {
        
        // 把选中的商品属性传过去，去刷新
        [self.filterView setSelectAttributeArr:self.selectedAttributeArr];
        
        [self.filterView setLastBuyCount:self.buyNum];
    }
}

#pragma mark - 按钮点击事件
- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        [self removeView];
        
    }else if (sender.tag == 1) {
        
        
        [self removeView];
        
    }
    
    
}

#pragma mark - 添加购物车前将数据准备好
- (NSMutableDictionary *)prepareGoodAttributeData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [self.selectedAttributeArr enumerateObjectsUsingBlock:^(NSString  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *tempArr = [obj componentsSeparatedByString:@"-"];
        
        NSInteger mainSelectedTag = [[tempArr objectAtIndex:1] integerValue];
        
        NSInteger subSelectedTag = [[tempArr objectAtIndex:2] integerValue];
        
        GoodAttrModel *mainModel = [self.productAttributeArr objectAtIndex:mainSelectedTag];
        
        GoodAttrValueModel *subModel = [mainModel.attr_value objectAtIndex:subSelectedTag];
        
        [dic setValue:subModel.attr_id forKey:mainModel.attr_id];
        
    }];
    
    return dic;
}

#pragma mark - GSFilterView Delegate

- (void)didClickAtModel:(ZYFilterModel *)data selectIndex:(NSString *)selectTag {
    
    NSString *tempStr = [data.elements objectAtIndex:[selectTag intValue]];
    
    NSString *mainTag = [NSString stringWithFormat:@"%ld",(long)data.tag];
    
    NSString *selectAttributeStr = [NSString stringWithFormat:@"%@-%@-%@-%@",data.title,mainTag,selectTag,tempStr];
    
    BOOL norepeat = YES;
    
    for (int i = 0; i<self.selectedAttributeArr.count; i ++) {
        
        NSString *tempStr = [self.selectedAttributeArr objectAtIndex:i];
        
        if ([[[tempStr componentsSeparatedByString:@"-"] firstObject] isEqualToString:[[selectAttributeStr componentsSeparatedByString:@"-"] firstObject] ]) {
            
            [self.selectedAttributeArr replaceObjectAtIndex:i withObject:selectAttributeStr];
            
            norepeat = NO;
            
            [self autoRecountPrice];
            
            return;
            
        }
        
    }
    
    if (norepeat) {
        
        [self.selectedAttributeArr addObject:selectAttributeStr];
        
        [self autoRecountPrice];
        
    }
    
    
}

- (void)dicChangeProductCount:(int)productCount {
    
    self.buyNum = productCount;
}


#pragma mark - 每当点击属性按钮时重新计算价格
- (void)autoRecountPrice {
    
    self.totalPrice = self.currentPrice;
    
    for (int i = 0; i < self.selectedAttributeArr.count; i++ ) {
        
        NSString *tempStr = [self.selectedAttributeArr objectAtIndex:i];
        
        int mainAttributeIndex = [[[tempStr componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
        
        int subAttributeIndex = [[[tempStr componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
        
        GoodAttrModel *mainAttribute =  [self.productAttributeArr objectAtIndex:mainAttributeIndex];
        
        GoodAttrValueModel *subAttribute = [mainAttribute.attr_value objectAtIndex:subAttributeIndex];
        
        self.totalPrice += subAttribute.attr_Price;
        
    }
    
    self.goodsPriceLbl.text = [NSString stringWithFormat:@"%.2f元",self.totalPrice];
    
}


#pragma mark - Public Method

#pragma mark - 视图出现
- (void)showInView:(UIView *)view {
    
    [view addSubview:self];
    
    __weak typeof(self) _weakSelf = self;
    
    self.contentView.frame = CGRectMake(0, kScreenH, kScreenW, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        _weakSelf.contentView.frame = CGRectMake(0, kScreenH - kATTR_VIEW_HEIGHT, kScreenW, kATTR_VIEW_HEIGHT);
        
    }];
}


#pragma mark - 视图消失
- (void)removeView {
    
    __weak typeof(self) _weakSelf = self;
    
    if (self.rememberBtnsClick) {
        
        if (self.buyNum == 0) {
            
            self.buyNum = 1;
            
        }
        
        NSString *buyCount = [NSString stringWithFormat:@"%d",self.buyNum];
        
        self.rememberBtnsClick(buyCount, self.totalPrice, self.selectedAttributeArr);
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _weakSelf.backgroundColor = [UIColor clearColor];
        
        _weakSelf.contentView.frame = CGRectMake(0, kScreenH, kScreenW, kATTR_VIEW_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        [_weakSelf removeFromSuperview];
        
    }];
}

#pragma Mark- 外部传入商品选中属性的数组，重新计算价钱，通知tableView去刷新

- (void)lastSelectedAttributeArr:(NSMutableArray *)arr  buyCount:(int)count {
    
    self.selectedAttributeArr = [NSMutableArray array];
    
    self.selectedAttributeArr = arr;
    
    //    [self autoRecountPrice];
    
    self.buyNum = count;
    
    [self defaultGoodAttributeArr];
}


#pragma mark - Setter 方法  设置 Icon, Name Price
- (void)setGood_img:(NSString *)good_img {
    
    _good_img = good_img;
    
    self.iconImgView.image = [UIImage imageNamed:good_img];
    
}
- (void)setGood_name:(NSString *)good_name {
    _good_name = good_name;
    self.goodsNameLbl.text = good_name;
}
- (void)setGood_price:(NSString *)good_price {
    _good_price = good_price;
    self.goodsPriceLbl.text = [NSString stringWithFormat:@"%@元", good_price];
    
    _totalPrice = [good_price floatValue];
    
    _currentPrice = [good_price floatValue];
}

@end
