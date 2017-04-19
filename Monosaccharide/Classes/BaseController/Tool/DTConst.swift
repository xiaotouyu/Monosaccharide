//
//  DTConst.swift
//  Monosaccharide
//
//  Created by dashuios126 on 17/2/17.
//  Copyright © 2017年 dashuios126. All rights reserved.
//

import UIKit

/// 动画时长
let kAnimationDuration: TimeInterval = 0.25

/// view动画时长
let kViewAnimationDuration: TimeInterval = 5

let kCornerRadius: CGFloat = 5.0

let kStatusBarH: CGFloat = 20
let kNavigationBarH: CGFloat = 44
let kTabBarH: CGFloat = 49
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 40
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height
let kColumnViewW = SCREENW                                       // 默认宽度
let kSpreadMaxH:CGFloat = SCREENH - 64

let kSpreadDuration = 0.4                                               // 动画展开收拢的时长
let kColumnLayoutCount = 4                                              // 排序item 每行个数
let kColumnViewH:CGFloat = 40.0
let kColumnItemH:CGFloat = (ZYinch55()) ? 40: 30                        // item的高度
let kColumnItemW:CGFloat = (ZYinch55()) ? 85: 70                        // item的宽度
let kColumnMarginW:CGFloat = (SCREENW-CGFloat(kColumnLayoutCount)*kColumnItemW)/CGFloat(kColumnLayoutCount+1)                                       // item的横向间距
let kColumnMarginH:CGFloat = (ZYinch55()) ? 20:((ZYinch47()) ? 20: 15)  // item的纵向间距
let kColumnEditBtnW:CGFloat = 120                                        // 排序删除按钮的宽度
let kColumnEditBtnH:CGFloat = 36                                        // 排序删除按钮的高度
let kColumnEditBtnFont:CGFloat = 14                                     // 排序删除按钮的字体
let kColumnEditBtnNorTitle = "排序或删除"                                   // 排序删除普通状态文字
let kColumnEditBtnSelTitle = "完成"                                      // 排序删除选中状态文字
let kColumnItemBorderColor = UIColor.red.cgColor                        // item的色环
let kColumnItemColor = UIColor.red                                      // item的文字颜色

let kColumnTitleMargin:CGFloat = 8                                      // title按钮之间默认没有间距，这个值保证两个按钮的间距
let kColumnTitleNorColor = UIColor.darkText                             // title普通状态颜色
let kColumnTitleSelColor = UIColor.red                                  // title选中状态颜色
let kColumnTitleNorFont:CGFloat = (ZYinch47() || ZYinch55()) ? 14 : 13  // title普通状态字体
let kColumnTitleSelFont:CGFloat = (ZYinch47() || ZYinch55()) ? 16 : 15  // title选中状态字体
let kColumnHasIndicator = true                                          // 默认有指示线条
let kColumnIndictorH:CGFloat = 2.0                                      // 指示线条高度
let kColumnIndictorMinW : CGFloat = 60                                  // 指示条默认最小宽度
let kColumnIndicatorColor = UIColor.red                                 // 默认使用系统风格颜色



/// 导航条 红色
func DTGlobalRedColor() -> UIColor {
    return DTColor(245, g: 80, b: 83, a: 1.0)
}
/// 背景灰色
func DTGlobalColor() -> UIColor {
    return DTColor(240, g: 240, b: 240, a: 1)
}

/// 线条灰色
func DTLineGlobalColor() -> UIColor {
    return DTColor(150, g: 149, b: 153, a: 1)
}

func DTDarkColor() -> UIColor {
    return UIColor.darkGray
}

/// 背景白色
func DTWhiteColor() -> UIColor {
    return DTColor(255, g: 255, b: 255, a: 1)
}

/// RGBA的颜色设置
func DTColor(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

func randomColor() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
}


/// 服务器地址
let BASE_URL = "http://api.dantangapp.com/"
/// code 码 200 操作成功
let RETURN_OK = 200

let DEFAULT_CHILDVCS: String = "default" // 首页初始化的子控制器
let HOME_CHILDVCS: String = "childvcs" // 首页contentView中的子控制器

/************** 常量定义 ****************/
/// 是否是3.5英寸屏
func ZYinch35() -> Bool {
    return UIScreen.main.bounds.size.height == 480.0
}

/// 是否是4.0英寸屏
func ZYinch40() -> Bool {
    return UIScreen.main.bounds.size.height == 568.0
}
/// 是否是4.7英寸屏
func ZYinch47() -> Bool {
    return UIScreen.main.bounds.size.height == 667.0
}
/// 是否是5.5英寸屏
func ZYinch55() -> Bool {
    return UIScreen.main.bounds.size.height == 736.0
}
