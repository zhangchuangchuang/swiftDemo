//
//  ZCBaseTableViewCell.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCBaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .none
        self.contentView.backgroundColor = kWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func cellHeight() -> CGFloat{
        return UITableView.automaticDimension
    }
    
    public class func  cellHeightWithModel(model:Any)->CGFloat{
        return UITableView.automaticDimension
    }
    public class func identifier() -> String{
        let name :AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
        
    }

}
