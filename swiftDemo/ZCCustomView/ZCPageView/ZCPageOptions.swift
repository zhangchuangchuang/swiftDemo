//
//  ZCPageOptions.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
import UIKit
public class ZCPageOptions{
    // 选项宽度
    public var kItemWidth : CGFloat = 40
    // 定义颜色 默认为选中颜色 (red,green,blue)
    public var kNormalColor : (CGFloat,CGFloat,CGFloat) = (99,99,99)
    // 选中的颜色 (red,green,blue)
    public var kSelectColor : (CGFloat,CGFloat,CGFloat) = (200,33,33)
    // label间距
    public var kMarginW : CGFloat = Adapt(20)
    // 是否允许标题滚动
    public var isTitleScrollEnable : Bool = true
    // 底部滚动线的高度
    public var kBotLineHeight : CGFloat = 3
    // 默认字体的Font大小
    public var kTitleFontSize : CGFloat = 13
    // 默认字体是否加粗
    public var kIsNormalFontBold : Bool = false
    // 选中的文本Font大小
    public var kTitleSelectFontSize : CGFloat? = nil
    // 底部滚动线的颜色
    public var kBotLineColor : UIColor = UIColor.orange
    // 是否显示滚动线
    public var isShowBottomLine : Bool = true
    // scrollView 的背景颜色
    public var kscrollViewBGColor : UIColor = kWhite
    // scrollView背景渐变色
    public var kGradColors : [CGColor]? = nil
    // 是否显示底部的分割线
    public var kIsShowBottomBorderLine : Bool = true
    // 底部分割线的颜色
    public var kBottomLineColor : UIColor = UIColor.gray
    
}
