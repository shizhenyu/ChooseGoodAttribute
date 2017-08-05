//
//  ViewController.m
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import "ViewController.h"

#import "GoodAttributeModel.h"
#import "ProductAttributeView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *goodArrtibuteArr;

/** 选中属性array */
@property (nonatomic, strong) NSMutableArray *selectedAttributeArr;

/** 上一次选中的数量 */
@property (nonatomic, assign) int lastBuyCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    self.goodArrtibuteArr = [NSMutableArray array];
    
    self.selectedAttributeArr = [NSMutableArray array];
    
    [self createProudctArrtibuteData];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(10, 30, 40, 40);
    button.backgroundColor = [UIColor orangeColor];
    
    [button addTarget:self action:@selector(createProductAttributeView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(60, 30, 320, 40);
    
    label.backgroundColor = [UIColor cyanColor];
    
    label.textColor = [UIColor redColor];
    
    label.adjustsFontSizeToFitWidth = YES;
    
    label.tag = 222;
    
    [self.view addSubview:label];
    
   
    
}

- (void)createProudctArrtibuteData {
    
    // 内存版本
    GoodAttrModel *memoryMainModel = [[GoodAttrModel alloc]init];
    
    memoryMainModel.attr_id = @"48";
    
    memoryMainModel.attr_name = @"内存";
    
    memoryMainModel.attr_value = [NSMutableArray array];
    
    GoodAttrValueModel *memorySubModel1 = [[GoodAttrValueModel alloc]init];
    
    memorySubModel1.attr_id = @"3605";
    
    memorySubModel1.attr_value = @"2GB+32GB";
    
    memorySubModel1.attr_Price = 0.00;
    
    GoodAttrValueModel *memorySubModel2 = [[GoodAttrValueModel alloc]init];
    
    memorySubModel2.attr_id = @"3606";
    
    memorySubModel2.attr_value = @"2GB+64GB";
    
    memorySubModel2.attr_Price = 300.00;
    
    
    GoodAttrValueModel *memorySubModel3 = [[GoodAttrValueModel alloc]init];
    
    memorySubModel3.attr_id = @"3607";
    
    memorySubModel3.attr_value = @"2GB+128GB";
    
    memorySubModel3.attr_Price = 500.00;
    
    GoodAttrValueModel *memorySubModel4 = [[GoodAttrValueModel alloc]init];
    
    memorySubModel4.attr_id = @"3608";
    
    memorySubModel4.attr_value = @"3GB+128GB";
    
    memorySubModel4.attr_Price = 1000.00;
    
    [memoryMainModel.attr_value addObject:memorySubModel1];
    [memoryMainModel.attr_value addObject:memorySubModel2];
    [memoryMainModel.attr_value addObject:memorySubModel3];
    [memoryMainModel.attr_value addObject:memorySubModel4];
    
    
    
    
    // 颜色版本
    GoodAttrModel *colorMainModel = [[GoodAttrModel alloc]init];
    
    colorMainModel.attr_id = @"49";
    
    colorMainModel.attr_name = @"颜色";
    
    colorMainModel.attr_value = [NSMutableArray array];
    
    GoodAttrValueModel *colorSubModel1 = [[GoodAttrValueModel alloc]init];
    
    colorSubModel1.attr_id = @"3701";
    
    colorSubModel1.attr_value = @"银色";
    
    colorSubModel1.attr_Price = 0.00;
    
    GoodAttrValueModel *colorySubModel2 = [[GoodAttrValueModel alloc]init];
    
    colorySubModel2.attr_id = @"3702";
    
    colorySubModel2.attr_value = @"金色";
    
    colorySubModel2.attr_Price = 0.00;
    
    
    GoodAttrValueModel *colorSubModel3 = [[GoodAttrValueModel alloc]init];
    
    colorSubModel3.attr_id = @"3703";
    
    colorSubModel3.attr_value = @"玫瑰金";
    
    colorSubModel3.attr_Price = 300.00;
    
    
    GoodAttrValueModel *colorSubModel4 = [[GoodAttrValueModel alloc]init];
    
    colorSubModel4.attr_id = @"3704";
    
    colorSubModel4.attr_value = @"深空灰";
    
    colorSubModel4.attr_Price = 300.00;
    
    GoodAttrValueModel *colorSubModel5 = [[GoodAttrValueModel alloc]init];
    
    colorSubModel5.attr_id = @"3705";
    
    colorSubModel5.attr_value = @"中国红";
    
    colorSubModel5.attr_Price = 400.00;
    
    GoodAttrValueModel *colorSubModel6 = [[GoodAttrValueModel alloc]init];
    
    colorSubModel6.attr_id = @"3706";
    
    colorSubModel6.attr_value = @"女神紫";
    
    colorSubModel6.attr_Price = 500.00;
    
    [colorMainModel.attr_value addObject:colorSubModel1];
    [colorMainModel.attr_value addObject:colorySubModel2];
    [colorMainModel.attr_value addObject:colorSubModel3];
    [colorMainModel.attr_value addObject:colorSubModel4];
    [colorMainModel.attr_value addObject:colorSubModel5];
    [colorMainModel.attr_value addObject:colorSubModel6];
    

    // 类型版本
    GoodAttrModel *typeModel = [[GoodAttrModel alloc]init];
    
    typeModel.attr_id = @"58";
    
    typeModel.attr_name = @"全网通";
    
    typeModel.attr_value = [NSMutableArray array];
    
    GoodAttrValueModel *typeSubModel1 = [[GoodAttrValueModel alloc]init];
    
    typeSubModel1.attr_id = @"3805";
    
    typeSubModel1.attr_value = @"全网通版";
    
    typeSubModel1.attr_Price = 500.00;
    
    GoodAttrValueModel *typeSubModel2 = [[GoodAttrValueModel alloc]init];
    
    typeSubModel2.attr_id = @"3806";
    
    typeSubModel2.attr_value = @"移动合约机";
    
    typeSubModel2.attr_Price = 200.00;
    
    GoodAttrValueModel *typeSubModel3 = [[GoodAttrValueModel alloc]init];
    
    typeSubModel3.attr_id = @"3807";
    
    typeSubModel3.attr_value = @"联通合约机";
    
    typeSubModel3.attr_Price = 300.00;
    
    
    
    [typeModel.attr_value addObject:typeSubModel1];
    [typeModel.attr_value addObject:typeSubModel2];
    [typeModel.attr_value addObject:typeSubModel3];
    
    
    
    [self.goodArrtibuteArr addObject:colorMainModel];
    
    [self.goodArrtibuteArr addObject:memoryMainModel];

    [self.goodArrtibuteArr addObject:typeModel];

}

- (void)createProductAttributeView {
    
    
    ProductAttributeView *attributesView = [[ProductAttributeView alloc] initWithFrame:(CGRect){0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height} withGoodAttributeArr:self.goodArrtibuteArr];
    
    attributesView.good_img = @"iPhone.jpg";
    
    attributesView.good_name = @"Apple（苹果）iPhone新版";
    
    attributesView.good_price = @"4388.00";
    
    [attributesView lastSelectedAttributeArr:self.selectedAttributeArr buyCount:self.lastBuyCount];
    
    [attributesView showInView:self.view];
    
    
    // block回调  将默认选择的商品属性和自己选择的返回过来
    
    __weak typeof(self)weakSelf = self;
    
    attributesView.rememberBtnsClick = ^(NSString *num, CGFloat totalPrice, NSMutableArray *selectedAttributeArr) {
        
        weakSelf.selectedAttributeArr = [NSMutableArray array];
        
        weakSelf.selectedAttributeArr = selectedAttributeArr;
        
        weakSelf.lastBuyCount = [num intValue];
        
        NSString *goodInfoStr = @"";
        
        for (NSString *obj in weakSelf.selectedAttributeArr) {
            
            goodInfoStr = [goodInfoStr stringByAppendingFormat:@" %@", [NSString stringWithFormat:@"%@",[[obj componentsSeparatedByString:@"-"] lastObject]]];
            
        }
        
        NSString *finalStr = [NSString stringWithFormat:@"%@   件数%@  总价：%.2f",goodInfoStr,num,totalPrice];
        
        UILabel *attributeLabel = [weakSelf.view viewWithTag:222];
        
        attributeLabel.text = finalStr;
        
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
