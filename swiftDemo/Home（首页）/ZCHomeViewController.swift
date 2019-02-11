//
//  ZCHomeViewController.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/22.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

private var isNavHidden :Bool = false

class ZCHomeViewController: UIViewController {

    //标题数组
    private lazy var titles:[String] = ["分类","推荐","全部","LOL","绝地求生","王者荣耀","QQ飞车"]
    private lazy var controllers : [UIViewController] = {
        let controllers = [ZCClassifyViewController(),ZCRecommendViewController(),ZCAllViewController(),ZCLolViewController(),ZCJDQSViewController(),ZCWZRYViewController(),ZCQQCarViewController()]
        return controllers
    }()
    //标题view
    private lazy var pageTitleView:ZCPageOptions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
