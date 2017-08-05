//
//  GoodAttributeModel.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodAttrModel : NSObject

/** 属性名 */
@property (nonatomic, copy) NSString *attr_name;
/** 属性ID */
@property (nonatomic, copy) NSString *attr_id;
/** 属性 */
@property (nonatomic, strong) NSMutableArray *attr_value;
@end


@interface GoodAttrValueModel : NSObject

/** 属性值 */
@property (nonatomic, copy) NSString *attr_value;

/** 属性id */
@property (nonatomic, copy) NSString *attr_id;

/** 属性价格 */
@property (nonatomic, assign) float attr_Price;
@end
