//
//  AnChorModel.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/14.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class AnChorModel: NSObject {
    // 房间ID
    var room_id : Int = 0
    
    // 房间图片对应的URL
    var vertical_src : String = ""
    
    // 判断手机直播还是电脑直播 0是电脑 1是手机
    var isVertical : Int = 0
    
    // 房间名称
    var room_name = ""
    
    // 昵称
    var nickname = ""
    
    var anchor_city : String = ""
    
    //在线人数
    var online = 0
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
