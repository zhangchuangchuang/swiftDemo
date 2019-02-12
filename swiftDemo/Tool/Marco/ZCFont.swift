//
//  ZCFont.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/2/11.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
import UIKit

func FontSize(_ size : CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: AdaptW(size))
}
func BoldFontSize(_ size :CGFloat)-> UIFont{
    return UIFont.boldSystemFont(ofSize: AdaptW(size))
}
