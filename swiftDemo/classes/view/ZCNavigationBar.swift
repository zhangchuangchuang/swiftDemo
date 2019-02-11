//
//  ZCNavigationBar.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        gradientLayer.startPoint = CGPoint.init(x:0,y:0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        gradientLayer.frame = frame
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
