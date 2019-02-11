//
//  ZCTabBarViewController.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/22.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

class ZCTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllViewController()
        self.tabBar.tintColor = UIColor.orange
        // Do any additional setup after loading the view.
    }
    func setUpAllViewController() -> Void {
        setUpChildController(ZCHomeViewController(),"推荐","tabLive","tabLiveHL")
        setUpChildController(ZCRecreationViewController(),"娱乐","tabYule","tabYuleHL")
        setUpChildController(ZCFollowViewController(), "关注","tabFocus", "tabFocusHL")
        setUpChildController(ZCFishBarViewController(), "鱼吧", "tabYuba", "tabYubaHL")
        setUpChildController(ZCDiscoverViewController(), "发现", "tabDiscovery", "tabDiscoveryHL")
        
        
        
    }
    private func setUpChildController(_ controller:UIViewController, _ title: String, _ norImage : String,_ selectedImage : String){
        controller.tabBarItem.title = title
        //修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -3)
        controller.tabBarItem.image = UIImage(named: norImage)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        let nav = ZCNavigationViewController(rootViewController:controller)
        controller.title = title
        self.addChild(nav)
        
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
