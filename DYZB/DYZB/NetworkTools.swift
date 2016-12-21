//
//  NetworkTools.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/8.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
