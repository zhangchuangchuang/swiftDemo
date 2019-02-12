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

class ZCHomeViewController: ZCBaseViewController {

    //标题数组
    private lazy var titles:[String] = ["分类","推荐","全部","LOL","绝地求生","王者荣耀","QQ飞车"]
    private lazy var controllers : [UIViewController] = {
        let controllers = [ZCClassifyViewController(),ZCRecommendViewController(),ZCAllViewController(),ZCLolViewController(),ZCJDQSViewController(),ZCWZRYViewController(),ZCQQCarViewController()]
        return controllers
    }()
    //标题view
    private lazy var pageTitleView:ZCPageTitleView = {[weak self] in
       let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
       let option = ZCPageOptions()
        option.kGradColors = kGradientColors
        option.kBotLineColor = kWhite
        option.kNormalColor = (220,220,220)
        option.kSelectColor = (250,250,250)
        option.kTitleSelectFontSize = 14
        option.isShowBottomLine = false
        option.kIsShowBottomBorderLine = false
        let pageTitleView = ZCPageTitleView(frame: frame, titles: titles, options: option)
        pageTitleView.delegate = self as? PageTitleViewDelegate
        return pageTitleView
    }()
    //内容
    private var pageContentView : ZJPageContentView{
        let height :CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
        let frame = CGRect(x: 0, y: kCateTitleH, width: kScreenW, height: height)
        let contentView = ZJPageContentView(frame: frame, childVCs: controllers, parentViewController: self)
        contentView.delegate = self as? ZJPageContentViewDelegate
        return contentView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(self.refreshNavBar), name: NSNotification.Name(rawValue:ZJNotiRefreshHomeNavBar ), object: nil)
        homeGetRecData()
    }
    func homeGetRecData(){
        ZJNetworkProvider.shared.requestDataWithTargetJSON(target: HomeAPI.getRecList1, successClosure: { (response) in
            print(response)
            }) { (error) in
                
        }
    }
    
    
    
    func douyuNewApiTest() {
        //        ZJNetWorking.requestData(type: .GET, URlString: ZJiosCheckUpdate) { (response) in
        //
        //        }
        //
        //        ZJNetWorking.requestData(type: .GET, URlString: ZJWB_ShareConfig) { (response) in
        //
        //        }
        
        //        ZJNetWorking.requestData(type: .GET, URlString: ZJtimestamp) { (response) in
        //            print(response)
        //        }
        
        let appDictM : NSMutableDictionary = NSMutableDictionary.init()
        appDictM.setValue("斗鱼", forKey: "aname")
        appDictM.setValue("tv.douyu.live", forKey: "pname")
        
        // device
        let deviceDictM : NSMutableDictionary = NSMutableDictionary.init()
        deviceDictM.setValue("750", forKey: "w")
        deviceDictM.setValue("1334", forKey: "h")
        deviceDictM.setValue("", forKey: "mac")
        deviceDictM.setValue("D2501EBB-E442-4168-8D37-E854FD9298C5", forKey: "idfa")
        deviceDictM.setValue("0", forKey: "devtype")
        deviceDictM.setValue("12.1", forKey: "osv")
        deviceDictM.setValue("iOS", forKey: "os")
        deviceDictM.setValue("", forKey: "imei")
        deviceDictM.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 12_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16B92, Douyu_IOS", forKey: "ua")
        deviceDictM.setValue("1", forKey: "op")
        deviceDictM.setValue("1", forKey: "nt")
        deviceDictM.setValue("iPhone 6", forKey: "model")
        
        let paramDictM : NSMutableDictionary = NSMutableDictionary.init()
        paramDictM.setValue(appDictM, forKey: "app")
        paramDictM.setValue("D2501EBB-E442-4168-8D37-E854FD9298C5", forKey: "idfa")
        paramDictM.setValue("iphone", forKey: "mdid")
        paramDictM.setValue(deviceDictM, forKey: "device")
        paramDictM.setValue("ios", forKey: "client_sys")
        
        //        print(paramDictM)
        
        if (!JSONSerialization.isValidJSONObject(paramDictM)) {
            print("无法解析出JSONString")
            
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: paramDictM, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        
        let dict : NSDictionary = NSDictionary(object: JSONString! as Any, forKey: "ad" as NSCopying)
        
        ZJNetWorking .requestData(type: .POST, URlString: ZJHomegetRecList1, parameters: dict as? [String : Any]) { (response) in
            
        }
    }
    
    
    
    
    @objc func refreshNavBar(noti:NSNotification){
        let isHidden:String = noti.userInfo!["isHidden"] as! String
        if isHidden == "true" {
            if isNavHidden {return}
            isNavHidden = true
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: kStatuHeight, width: kScreenW, height: kCateTitleH)
                let height:CGFloat = kScreenH - kStatuHeight - kCateTitleH - kTabBarHeight
                let frame = CGRect(x: 0, y: kCateTitleH+kStatuHeight, width: kScreenW, height: height)
                self.pageContentView.frame = frame
                self.pageContentView.refreshColllectionView(height: self.pageContentView.frame.size.height)
            }
        }else{
            if !isNavHidden{return}
            isNavHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
                let height:CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
                let frame = CGRect(x: 0, y: kCateTitleH, width: kScreenW, height: height)
                self.pageContentView.frame = frame
                
                
            }
            
            }
        }
    override func rightItemClick(){
        super.rightItemClick()
    }
}

extension ZCHomeViewController :PageTitleViewDelegate,ZJPageContentViewDelegate{
    func pageTItleView(titleView: ZCPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    func zj_pageContentView(contentView: ZJPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
extension ZCHomeViewController{
    func setUpAllView(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(statuView)
        setUpNavigation()
        setUpPageTitleAndCotentView()
    }
    func setUpPageTitleAndCotentView(){
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}
