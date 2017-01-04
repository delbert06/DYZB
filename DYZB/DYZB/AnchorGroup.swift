//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/14.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {
    // MARK: - 定义属性
    // 该组中对应的房间信息
    var room_list : [[String : AnyObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list{
                anchors.append(AnChorModel(dict:dict))
            }
        }
    }
    var icon_name : String = ""
    
    // 定义主播数组
    lazy var anchors : [AnChorModel] = [AnChorModel]()
}
