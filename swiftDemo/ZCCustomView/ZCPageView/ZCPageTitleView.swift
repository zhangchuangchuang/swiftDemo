//
//  ZCPageTitleView.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
protocol PageTitleViewDelegate:class {
    func pageTItleView(titleView:ZCPageTitleView,selectedIndex:Int)
}

class ZCPageTitleView: UIView {
    //代理协议
    weak var delegate:PageTitleViewDelegate?
    //滚动 view
    private lazy var scrollerView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
   //底部滚动条
    private lazy var scrollLine:UIView = {
        let scrollLine  = UIView()
        scrollLine.backgroundColor = option.kBotLineColor
        return scrollLine
    }()
    //底部的分割线
    private lazy var bottomLine:UIView = {
        let botLine = UIView()
        let botH :CGFloat = 0.5
        botLine.backgroundColor = option.kBottomLineColor
        botLine.frame = CGRect(x: 0, y: frame.height-botH, width: frame.width, height:botH)
        return botLine
    }()
    private lazy var option:ZCPageOptions = {
        let option = ZCPageOptions()
        return option
    }()
    
    //创建一个 lable 数组
    private lazy var titleLabs:[UILabel] = [ UILabel]()
    //标题
    private var titles:[String]
    //索引
    private var currentIndex :Int = 0
     init(frame: CGRect,titles :[String],options:ZCPageOptions?=nil) {
        self.titles = titles
        super.init(frame: frame)
        if options != nil{
            self.option = options!
        }
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
     
    }
}

extension ZCPageTitleView{
    private func setUpAllView(){
        addSubview(scrollerView)
        scrollerView.frame = bounds
        setUpTitleLabel()
        setBottomMenuAndScrollerLine()
        if option.kGradColors != nil {
            let gradientLayer: CAGradientLayer = CAGradientLayer()
            gradientLayer.colors = option.kGradColors
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0 )
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
            gradientLayer.frame = bounds;
            self.layer.insertSublayer(gradientLayer, at: 0)
            
        }else{
            scrollerView.backgroundColor = option.kscrollViewBGColor
        }
    }
    private func setUpTitleLabel(){
        for (index,title) in titles.enumerated() {
            let lab = UILabel()
            lab.text = title
            lab.tag = index
            
        }
        
    }
    private func setBottomMenuAndScrollerLine(){
        
    }
    func setUpBottomLine(){
        guard option.isShowBottomLine else {
            return
        }
        scrollerView.addSubview(scrollLine)
    }
}
