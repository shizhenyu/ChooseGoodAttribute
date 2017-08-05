//
//  ZYFilterMacro.h
//  ChooseGoodAttribute
//
//  Created by 史振宇 on 2017/8/5.
//  Copyright © 2017年 Youzeshi. All rights reserved.
//

#ifndef ZYFilterMacro_h
#define ZYFilterMacro_h

#define RGBCOLOR(_R_, _G_, _B_) [UIColor colorWithRed:(_R_)/255.0 green: (_G_)/255.0 blue: (_B_)/255.0 alpha: 1.0]

#define ZY_NORMAL_COLOR RGBCOLOR(189,189,189) // 默认的button外面的边角颜色
#define ZY_HL_COLOR RGBCOLOR(104,105,106) // 示例点击标题颜色

#define ZY_NOTIFICATION_BUTTON_CLICKED @"ZYFilterButtonClicked"

#define ZY_DEFAULT_TITLE_COLOR RGBCOLOR(23,23,23)   //上部标题的颜色

#define ZY_SELECTBORDER_COLOR RGBCOLOR(252,61,7)//选中边框颜色
#define ZY_NORMALBORDER_COLOR RGBCOLOR(233,234,235)//未选中边框颜色

#define ZY_NORMALTITLE_COLOR RGBCOLOR(104,105,106)//未选中标题颜色
#define ZY_SELECTTITLE_COLOR RGBCOLOR(255,255,255)//选中标题颜色

#define ZY_SELECTBACKGROUND_COLOR RGBCOLOR(252,61,7)//选中按钮背景颜色
#define ZY_NORMALBACKGROUND_COLOR RGBCOLOR(255,255,255)//选中按钮背景颜色

#define zScreenWidth [UIScreen mainScreen].bounds.size.width
#define zScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* ZYFilterMacro_h */
