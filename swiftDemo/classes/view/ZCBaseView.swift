//
//  ZCBaseView.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kWhite
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
