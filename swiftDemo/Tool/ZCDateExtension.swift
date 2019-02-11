//
//  ZCDateExtension.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
//时间戳转时间
func getTimeStamp() -> String {
    //获取当前时间
    let now = NSDate()
    //当前时间的时间戳
    let timeInterval : TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return "\(timeStamp)"
}
//时间转时间戳
func getMilliStamp() -> String {
    //获取当前时间
    let now = NSDate()
    //当前时间的时间戳
    let timeInterval : TimeInterval = now.timeIntervalSince1970
    let millisecond = CLongLong(round(timeInterval*1000))
    return "\(millisecond)"
    
}
