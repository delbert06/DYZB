//
//  CycleModel.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/21.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var pic_url : String = ""
    var title : String = ""
    
    var room : [String : NSObject]? {
        didSet{
            guard let room = room else { return }
            anchor = AnChorModel(dict: room)
        }
    }
    
    var anchor : AnChorModel?
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
