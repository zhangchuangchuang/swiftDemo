//
//  ZCHomeAPI.swift
//  swiftDemo
//
//  Created by 张闯闯 on 2019/1/24.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import Foundation
import UIKit
import Moya

let HomeProvider = MoyaProvider<HomeAPI>()
public enum HomeAPI{
    case recommendCategotyList//分类推荐类表
    case liveCateList//分类列表
    case getRecList1//热门推荐
}

extension HomeAPI:TargetType{
 
    public var baseURL:URL{
        switch self {
        case .recommendCategotyList:
            return URL(string: "https://apiv2.douyucdn.cn")!
        case .liveCateList:
            return URL(string: "https://apiv2.douyucdn.cn")!
        case .getRecList1:
            return URL(string: "https://apiv2.douyucdn.cn")!
            
        }
    }
    
    public var path: String{
        switch self {
        case .recommendCategotyList:
            return "/live/cate/getLiveRecommendCate2"
        case .liveCateList:
            return "/live/cate/getLiveCate1List"
        case .getRecList1:
            return "/mgapi/livenc/home/getRecList1"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .recommendCategotyList:
            return .get
        case .liveCateList:
            return .get
        case .getRecList1:
            return .post
        }
    }
    public var task: Task {
        switch self {
        case .recommendCategotyList,.liveCateList:
            var params:[String:Any] = [:]
            params["client_sys"] = "ios"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getRecList1:
            var  params:[String:Any] = [:]
            params["client_sys"] = "ios"
            params["limit"] = "10"
            params["offset"] = "0"
            
            let appDictM : NSMutableDictionary = NSMutableDictionary.init()
            appDictM.setValue("斗鱼", forKey: "aname")
            appDictM.setValue("tv.douyu.live", forKey: "pname")
            
            let deviceDictM:NSMutableDictionary = NSMutableDictionary.init()
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
            
            if (!JSONSerialization.isValidJSONObject(paramDictM)){
                print("无法解析出JSONString")
            }
            let data : NSData! = try? JSONSerialization.data(withJSONObject: paramDictM, options: .prettyPrinted) as NSData
            let JSONString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
            
            params["ad"] = JSONString! as String
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
            
        }
    }
    public var validate:Bool{
        return false
    }
    
    public var sampleData: Data {
        return "{}" .data(using: String.Encoding.utf8)!
    }
    public var headers: [String : String]? {
        // 配置 HTTPHeaders
        let headers: [String : String] = [
            "charset":"utf-8",
            "Cookie" : "acf_did=6412f66c83a322e90fa3307d00001521",
            "User-Device": "NjQxMmY2NmM4M2EzMjJlOTBmYTMzMDdkMDAwMDE1MjF8NS4wMDA=",
            "time" : getTimeStamp(),
            "auth" : "f390ebfa09d1dbe6765e91f82ee62b34",
            "aid"  : "ios",
            "User-Agent" : "ios/5.000 (ios 12.1; ; iPhone 6 (A1549/A1586))",
            "Accept-Encoding" : "br, gzip, deflate",
            "Content-Type" : "application/x-www-form-urlencoded",
            ]
        return headers
    }
    
}

