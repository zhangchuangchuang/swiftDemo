//
//  ZCPopupBaseView.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCPopupBaseView: UIView {

  typealias CusHiddenBlock = ()->()
    var cusBlock : CusHiddenBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func zj_popupViewhiddenAction(){
        if cusBlock != nil{
            cusBlock!()
        }
    }

}
