//
//  ZYFilterCell.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "ZYFilterCell.h"

#import "ZYFilterModel.h"
#import "ZYFilterMacro.h"

#import "SelectBtn.h"
#import "ModelBtn.h"

@interface ZYFilterCell ()
{
    NSInteger BtnlineNum;
    CGFloat Btnx;
    CGFloat totalHeight;
    
    CGFloat oneLineBtnWidtnLimit;
    CGFloat btnGap;
    CGFloat btnGapY;
    CGFloat BtnHeight;
    CGFloat minBtnLength;
    CGFloat maxBtnLength;
    
    NSMutableArray *rowHeightArray;
}

@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) NSMutableArray *selectedbuttons;
@property (nonatomic,weak) ZYFilterModel *filterData;

@property (nonatomic,strong) UIButton *selectingButton;

@end

@implementation ZYFilterCell

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        // 颜色的设置
        self.buttonNormalColor = ZY_NORMALTITLE_COLOR; //未选中标题颜色
        self.buttonHighlightColor = ZY_SELECTTITLE_COLOR; //选中标题颜色
        self.buttonNormalBorderColor = ZY_NORMALBORDER_COLOR; //未选中边框颜色
        self.buttonSelectBorderColor = ZY_SELECTBORDER_COLOR;  //选中边框颜色
        self.buttonNormalBackGroundColor = ZY_NORMALBACKGROUND_COLOR; //选中按钮的背景色
        self.buttonSelectBackGroundColor = ZY_SELECTBACKGROUND_COLOR; //未选中按钮背景颜色
        
        rowHeightArray = [NSMutableArray array];
        
    }
    
    return self;
}

- (instancetype)init:(ZYFilterModel *)model Width:(CGFloat)width {
    
    self = [self init];
    
    if (self) {
        
        _filterData = model;
        _maxViewWidth = width;
        _selectedbuttons = [[NSMutableArray alloc]initWithCapacity:5];
        _buttons = [[NSMutableArray alloc]initWithCapacity:_filterData.elements.count];
        
        UIView *subView = [UIView new];
        
        subView.tag = 444;
        
        [self addSubview:subView];
        
        //接收到数据后  创建按钮并设置cell高度
        if (_buttons.count != _filterData.elements.count) {
            
            [self initButtons];
            
            [[self viewWithTag:444] removeFromSuperview];
            
        }
        
        self.frame = CGRectMake(0, 0, _maxViewWidth, [self getEstimatedHeight]);
    }
    
    return self;
}

- (void)initButtons {
    
    [_buttons removeAllObjects];
    
    totalHeight = 0;
    oneLineBtnWidtnLimit = zScreenWidth - 30; //每行btn占的最长长度，超出则换行
    btnGap = 10; //btn的x间距
    btnGapY = 13;
    BtnlineNum = 0;
    BtnHeight = 30;
    
    minBtnLength = 40; //每个btn的最小长度
    maxBtnLength = oneLineBtnWidtnLimit - btnGap*2; //每个btn的最大长度
    Btnx = 0;
    
    [_filterData.elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        
        Btnx += btnGap;
        
        CGFloat btnWidth = [self WidthWithString:obj fontSize:14 height:BtnHeight];
        btnWidth += 10;  //让文字两端留出间距
        
        if (btnWidth < minBtnLength) {
            
            btnWidth = minBtnLength;
            
        }
        
        if (btnWidth > maxBtnLength) {
            
            btnWidth = maxBtnLength;
        }
        
        if (Btnx + btnWidth > oneLineBtnWidtnLimit) {
            
            BtnlineNum ++;  //长度超出换到下一行
            
            Btnx = btnGap;
            
        }
        
        UIButton *button = [[UIButton alloc]init];
        
         //Y坐标
        CGFloat height = btnGapY + (BtnlineNum*(BtnHeight + btnGapY));
        
        button.frame = CGRectMake(Btnx, height, btnWidth, BtnHeight);
        
        button.layer.borderWidth = 1;
        
        button.layer.cornerRadius = 8;
        
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        button.titleLabel.minimumScaleFactor = 0.5;
        
        [button setTitle:obj forState:UIControlStateNormal];
        
        [button setTitleColor:self.buttonNormalColor forState:UIControlStateNormal];
        
        button.layer.borderColor = [self.buttonNormalBorderColor CGColor];
        
        button.selected = NO;
        button.tag = idx;
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        [_buttons addObject:button];
        
        Btnx = button.frame.origin.x + button.frame.size.width + btnGap;
        
        totalHeight = height;
        
    }];
    
}

- (void)buttonSelected:(UIButton *)button{
    
    self.filterData.clickedButtonText = button.titleLabel.text;
    
    ModelBtn *model = [ModelBtn new];
    model.title = button.titleLabel.text;
    //    model.tag = button.tag;
    [SelectBtn sharedManager].modelBtn = model;
    
    
    //    NSLog(@"%ld  %@",(long)[SelectBtn sharedManager].modelBtn.tag,[SelectBtn sharedManager].modelBtn.title);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *selectIndex = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    [dic setObject:self.filterData forKey:@"data"];
    
    [dic setObject:selectIndex forKey:@"selectIndex"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZY_NOTIFICATION_BUTTON_CLICKED
                                                        object:dic];
    
    if (button.selected) {
        
        
    }else{
        for (UIButton *button in self.selectedbuttons) {
            [button setTitleColor:self.buttonNormalColor forState:UIControlStateNormal];
            button.layer.borderColor = [self.buttonNormalBorderColor CGColor];
            button.selected = NO;
            [button setBackgroundColor:self.buttonNormalBackGroundColor];
            
        }
        
        [self.selectedbuttons removeAllObjects];
        
        button.layer.borderColor = [self.buttonSelectBorderColor CGColor];
        [button setTitleColor:self.buttonHighlightColor forState:UIControlStateNormal];
        button.selected = YES;
        [button setBackgroundColor:self.buttonSelectBackGroundColor];
        [self.selectedbuttons addObject:button];
    }

}


#pragma mark - self tools
//根据字符串计算宽度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}

-(CGFloat)getEstimatedHeight{
    
    return totalHeight + 45;
    
}

- (void)setSelectedChoice:(NSString *)choice{
    
    static  NSInteger selectedTag = 0;
    
    for (UIButton *selectedButton in _buttons) {
        
        if ([selectedButton.titleLabel.text isEqualToString:choice]) {
            
            selectedButton.layer.borderColor = [self.buttonSelectBorderColor CGColor];
            
            [selectedButton setTitleColor:self.buttonHighlightColor forState:UIControlStateNormal];
            
            selectedButton.selected = YES;
            
            selectedTag = selectedButton.tag;
            
            [selectedButton setBackgroundColor:self.buttonSelectBackGroundColor];
            
            [self.selectedbuttons addObject:selectedButton];
        }
        
    }
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *selectIndex = [NSString stringWithFormat:@"%ld",(long)selectedTag];
    
    [dic setObject:self.filterData forKey:@"data"];
    
    [dic setObject:selectIndex forKey:@"selectIndex"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZY_NOTIFICATION_BUTTON_CLICKED
                                                        object:dic];
}

- (NSArray *)getSelectedValues{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (UIButton *button in self.selectedbuttons) {
        
        [array addObject:button.titleLabel.text];
        
    }
    return array;
}
@end
