//
//  ZCBaseCollectionCell.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCBaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = kWhite
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func itemHeight() -> CGSize{
        return CGSize(width: 0.0, height: 0.0)
    }
    public class func itemHeightWithModel(model:Any) -> CGSize{
        return CGSize(width: 0.0, height: 0.0)
    }
    public class func identifier() ->String{
        let name:AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
    }
    
}
