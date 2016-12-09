//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/9.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {

}

// MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData() {
        NetworkTools.requestData(.GET, URLString: "http://httpbin.org/get", parameters: ["name":"HD"]) {(result) in
            print(result)
        }
    }
}
