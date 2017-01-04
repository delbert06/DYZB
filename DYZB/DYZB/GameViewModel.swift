//
//  GameViewModel.swift
//  DYZB
//
//  Created by 胡迪 on 2017/1/4.
//  Copyright © 2017年 D.Huhu. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    lazy var games : [GameModel] = [GameModel]()
}

    // MARK: - 网络请求
extension GameViewModel {
    func loadGameData(finished : @escaping() -> ()){
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray{
                self.games.append(GameModel(dict : dict))
            }
            
            finished()
        }
    }
}
