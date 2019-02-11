//
//  ZCPopupView.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
import UIKit
enum ZCPopupAnimationStyle{
    case ZJPopTransition //移动
    case ZJRotation      //旋转
    case ZJPopupSacle    //缩放动画
    case ZJAlpha         //渐变
}
class ZCPopupView: UIView,ZCPopupViewDelegate{
    
    var popupStyle : ZCPopupAnimationStyle? = .ZJPopupSacle
    lazy var customView : ZCPopupBaseView = {
        let customView = ZCPopupBaseView()
        customView.backgroundColor = kWhite
        customView.layer.cornerRadius = 5
        return customView;
    }()
    var isBGClickAction :Bool = true
    var durationTime :Double = 0.25
    var bgAlpha :CGFloat = 0.5
    var cusviewSize :CGSize
    
    init(size:CGSize,customView:ZCPopupBaseView?=nil,style:ZCPopupAnimationStyle) {
        cusviewSize = size
        super.init(frame: UIScreen.main.bounds)
        popupStyle = style
        self.isHidden = true
        self.backgroundColor = colorWithRGBA(33, 33, 33, bgAlpha)
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        if customView != nil {
            assert((customView?.isKind(of: ZCPopupBaseView.self))!,"customView 必须继承 ZCPopupBaseView")
            self.customView = customView!
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func zj_showPopView() {
        self.alpha = 0.0
        self.isHidden = false
        switch popupStyle {
        case .ZJPopTransition?:
            self.customView.transform = self.customView.transform.concatenating(CGAffineTransform(translationX: 0, y: -(kScreenH-self.cusviewSize.height)/2))
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 1.0
                self.customView.transform = self.customView.transform.concatenating(CGAffineTransform(translationX: 0, y: (kScreenH-self.cusviewSize.height)/2+50))
                }) { (isSuccess) in
                    UIView.animate(withDuration: self.durationTime/2, animations: {
                        self.customView.transform = self.customView.transform.concatenating(CGAffineTransform(translationX: 0, y: -50))
                    })
            }
            break
        case .ZJRotation?:
            self.alpha = 1.0
            
            // 旋转缩放动画使用 CABasicAnimation 基本动画实现
            let scaleAnima = CABasicAnimation(keyPath: "transform.scale")
            // 0.2 -> 1.0
            scaleAnima.toValue = 1.0
            scaleAnima.fromValue = 0.2
            
            let rotaAnima = CABasicAnimation(keyPath: "transform.rotation.z")
            rotaAnima.toValue = Double.pi * 2
            // 组动画
            let groupAnima = CAAnimationGroup()
            groupAnima.animations = [scaleAnima,rotaAnima]
            groupAnima.duration = durationTime*2
            // 添加到 layer 上
            self.customView.layer.add(groupAnima, forKey: "groupAnimation")
            
            break
        case .ZJPopupSacle?:
            self.customView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 1.0
                self.customView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (isSuccess) in
                
            }
            break
        case .ZJAlpha?:
            self.customView.alpha = 0.0
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 1.0
                self.customView.alpha = 1.0
            }) { (isSuccess) in
                
            }
            break
        default:
            break
        }
    }
    
    func zj_dissmissPopView() {
        switch popupStyle {
        case .ZJPopTransition?:
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        case .ZJRotation?:
            
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            
            break
        case .ZJPopupSacle?:
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        case .ZJAlpha?:
            UIView.animate(withDuration: durationTime, animations: {
                self.customView.alpha = 0.0
            }) { (isSccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        default:
            break
            
        }
    }
    
    @objc private func zj_bgViewTap(){
        guard isBGClickAction else {
            return
        }
        self.zj_dissmissPopView()
    }
    
    @objc private func zj_cusTap(){
        
    }
    
}
extension ZCPopupView{
    private func setUpAllView(size:CGSize){
        self.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
    }
}
