//
//  ZCAlertViewController.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCAlertViewController: UIAlertController {
//弹窗aler
    static func zj_showAlertView(currentController:UIViewController,title:String,message:String,confirmTitle:String,cancelTitle:String,confirmHandler:@escaping ((UIAlertAction)-> Void),cancelHandel:@escaping((UIAlertAction)->Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .default) { (action) in
            cancelHandel(action)
        }
        //确定按钮
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandler(action)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        currentController.present(alert, animated: true, completion: nil)
    }
    //底部sheet 弹窗
    static func zj_showSheetView(currentController:UIViewController,title:String,message:String,actionArray:[String],confirmTitle:String,cancelTitle:String,actionHandle:@escaping((UIAlertAction)->Void),cancelHandel:@escaping((UIAlertAction)->Void)){
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionArray.forEach { (item) in
            let action = UIAlertAction(title: item, style:.default, handler: { (action) in
                actionHandle(action)
            })
            sheet.addAction(action)
        }
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelHandel(action)
        }
        sheet.addAction(cancel)
         currentController.present(sheet, animated: true, completion: nil)
        
        
    }

}
