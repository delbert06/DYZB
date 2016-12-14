//
//  NSDateEtension.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/9.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import Foundation

extension Date{
    static func getCurrentTime()-> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
