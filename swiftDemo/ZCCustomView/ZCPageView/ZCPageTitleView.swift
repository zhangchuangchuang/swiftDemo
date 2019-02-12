//
//  ZCPageTitleView.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
protocol PageTitleViewDelegate:class {
    func pageTItleView(titleView:ZCPageTitleView,selectedIndex index:Int)
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
    private lazy var option : ZCPageOptions = {
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
    
    private func setupLabelsLayout(){
        let labelH = frame.size.height
        let labelY:CGFloat = 0
        var labelW:CGFloat = 0
        var labelX:CGFloat = 0
        
        let count = titleLabs.count
        for (i,titleLabel) in titleLabs.enumerated() {
            if option.isTitleScrollEnable{
               
                labelW = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : titleLabel.font], context: nil).width
                labelX = i == 0 ? option.kMarginW * 0.5 : (titleLabs[i-1].frame.maxX + option.kMarginW)
            }else if option.kItemWidth != 0{
                labelW = option.kItemWidth
                labelX = labelW*CGFloat(i)
            }else{
                labelW = bounds.width / CGFloat(count)
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW+Adapt(10), height: labelH)
        }
        
        if option.isTitleScrollEnable{
            guard let titleLabel = titleLabs.last else {return}
            scrollerView.contentSize.width = titleLabel.frame.maxX + option.kMarginW * 0.5
        }
    }
    private func setupBottomLineLayout() {
        guard titleLabs.count - 1 >= currentIndex else {
            return
        }
        let  label = titleLabs[currentIndex]
        scrollLine.frame.origin.x = label.frame.origin.x
        scrollLine.frame.size.width = label.frame.width
        scrollLine.frame.size.height = option.kBotLineHeight
        scrollLine.frame.origin.y = self.bounds.height - option.kBotLineHeight
    }
    private func adjustLabelPosition(_ targetLabel : UILabel){
        guard option.isTitleScrollEnable else {
            return
        }
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollerView.contentSize.width - scrollerView.bounds.width {
            offsetX = scrollerView.contentSize.width - scrollerView.bounds.width
        }
        scrollerView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
    
}
extension ZCPageTitleView{
    func setPageTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        let sourceLab = titleLabs[sourceIndex]
        let targetLab = titleLabs[targetIndex]
        
        //处理滑块
        let movtotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let movX = movtotalX * progress
        scrollLine.frame.origin.x = sourceLab.frame.origin.x + movX
        
        //颜色的渐变
        //取出颜色变化的范围
        let colorDelta = (option.kSelectColor.0 - option.kNormalColor.0, option.kSelectColor.1 - option.kNormalColor.1,option.kSelectColor.2 - option.kNormalColor.2)
        
        // 变化 sourceLab 的文字颜色
        sourceLab.textColor = colorWithRGBA(option.kSelectColor.0 - colorDelta.0 * progress, option.kSelectColor.1 - colorDelta.1 * progress, option.kSelectColor.2 - colorDelta.2 * progress, 1.0)
        
        
        // 变化 targetLab 的文字颜色
        targetLab.textColor = colorWithRGBA(option.kNormalColor.0 + colorDelta.0 * progress, option.kNormalColor.1 + colorDelta.1 * progress, option.kNormalColor.2 + colorDelta.2 * progress, 1.0)
        if option.kTitleSelectFontSize != nil{
            sourceLab.font = option.kIsNormalFontBold ? BoldFontSize(option.kTitleSelectFontSize! - (option.kTitleSelectFontSize! - option.kTitleFontSize) * progress) : FontSize(option.kTitleSelectFontSize! - (option.kTitleSelectFontSize! - option.kTitleFontSize) * progress)
            targetLab.font = BoldFontSize (option.kTitleSelectFontSize! + (option.kTitleSelectFontSize! - option.kTitleFontSize)  * progress)
            setupLabelsLayout()
        }
        
        // 底部滚动条滚动
        //        if option.isShowBottomLine {
        adjustLabelPosition(targetLab)
        //        }
        
        if option.isShowBottomLine {
            let deltaX = targetLab.frame.origin.x - sourceLab.frame.origin.x
            let deltaW = targetLab.frame.width - sourceLab.frame.width
            scrollLine.frame.origin.x = sourceLab.frame.origin.x + progress * deltaX
            scrollLine.frame.size.width = sourceLab.frame.width + progress * deltaW
        }
        // 记录最新的 index
        currentIndex = targetIndex
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
            
            lab.font = option.kIsNormalFontBold ? BoldFontSize(option.kTitleFontSize) : FontSize(option.kTitleFontSize)
            lab.textColor = colorWithRGBA(option.kNormalColor.0, option.kNormalColor.1, option.kNormalColor.2, 1.0)
            lab.textAlignment = .center
            // 添加 lab
            scrollerView.addSubview(lab)
            titleLabs.append(lab)
            // 添加点击事件
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGesture:)))
            lab.addGestureRecognizer(tap)
            
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



extension ZCPageTitleView{
    @objc fileprivate func titleLabelClick(tapGesture:UITapGestureRecognizer){
        if tapGesture.view?.tag == currentIndex {
            return
        }
        let currentLab = tapGesture.view as? UILabel
        //获取之前的lab
        let oldLab = titleLabs[currentIndex]
        currentLab?.textColor = colorWithRGBA(option.kSelectColor.0, option.kSelectColor.1, option.kSelectColor.2, 1.0)
        oldLab.textColor = colorWithRGBA(option.kNormalColor.0, option.kNormalColor.1, option.kNormalColor.2, 1.0)
        
        //修改字体大小
        if option.kTitleSelectFontSize != nil {
            currentLab?.font = BoldFontSize(option.kTitleSelectFontSize!)
            oldLab.font = option.kIsNormalFontBold ? BoldFontSize(option.kTitleFontSize):FontSize(option.kTitleFontSize)
            setupLabelsLayout()
        }
        currentIndex = (currentLab?.tag)!
        //滚动条位置发生改变
        let scrollLineX = CGFloat((currentLab?.tag)!) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15){
            self.scrollLine.frame.origin.x  = scrollLineX
        }
        
        
    }
}
