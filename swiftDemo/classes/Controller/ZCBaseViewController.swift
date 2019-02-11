//
//  ZCBaseViewController.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/22.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCBaseViewController: UIViewController {

    lazy var statuView :UIView = {
        let view = UIView()
        view.backgroundColor = kMainOrangeColor
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kStatuHeight)
        //设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0 )
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kWhite
        if #available(iOS 11.0, *) {
            automaticallyAdjustsScrollViewInsets = false
        }

    }
    override func didReceiveMemoryWarning() {
        super .didReceiveMemoryWarning()
    }
    
    func setUpNavigation(){
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "btn_user_normal"), style:.done, target: self, action: #selector(self.leftItemClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "viewHistoryIcon"), style: .done, target: self, action: #selector(self.rightItemClick))
        
        
    }
    @objc func leftItemClick(){
        
        
    }
    @objc func rightItemClick(){
        
    }
}
