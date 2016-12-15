//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/9.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
// MARK: - 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback:@escaping ()->()) {
        
        let parameters = ["limit" : "4","offset" : "0","time" : Date.getCurrentTime()]
        let dGroup = DispatchGroup()
        // 1. 请求第一部分推荐数据
        
        dGroup.enter()
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray{
                let group = AnChorModel(dict: dict)
                self.bigDataGroup.anchors.append(group)
            }
            dGroup.leave()
        }
        
        // 2. 请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray{
                let anchor = AnChorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        // 3. 请求第三部分游戏数据
        dGroup.enter()
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {(result) in
            // 1. 将result转成字典
            guard let resultDic = result as? [String : NSObject] else {return}
            // 2. 根据data的key获取数组  // resultDic["data"] 就是字典的key
            guard let dataArray = resultDic["data"] as? [[String :NSObject]] else {return}
            // 3. 便利数组，获取字典，并将字典转化成模型数组
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
}
