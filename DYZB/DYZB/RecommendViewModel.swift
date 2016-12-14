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
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData() {
//        NetworkTools.requestData(.GET, URLString: "http://httpbin.org/get", parameters: ["name":"HD"]) {(result) in
//            print(result)
        // 1. 请求第一部分颜值数据
        
        // 2. 请求第二部分推荐数据
        
        // 3. 请求第三部分游戏数据
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:  ["limit" : "4","offset" : "0","time" : Date.getCurrentTime()]) {(result) in
            // 1. 将result转成字典
            guard let resultDic = result as? [String : AnyObject] else {return}
            // 2. 根据data的key获取数组  // resultDic["data"] 就是字典的key
            guard let dataArray = resultDic["data"] as? [[String :AnyObject]] else {return}
            // 3. 便利数组，获取字典，并将字典转化成模型数组
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups{
//                print(group.tag_name)
                for anchor in group.anchors{
                    print(anchor.nickname)
                }
            }
        }
    }
}
