//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/14.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    // 该组中对应的房间信息
    var room_list : [[String : AnyObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list{
                anchors.append(AnChorModel(dict:dict))
            }
        }
    }
    
    // 该组显示的标题
    var tag_name : String = ""
    
    // 该组的图标
    var icon_name : String = "home_header_normal"
    
    // 定义主播数组
    lazy var anchors : [AnChorModel] = [AnChorModel]()
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            guard let dataArray = value as? [[String:AnyObject]] else {return}
//            for dict in dataArray{
//                anchors.append(AnChorModel(dict:dict))
//            }
//        }
//    }
}
