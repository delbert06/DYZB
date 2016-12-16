//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/16.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchor : AnChorModel? {
        didSet{
            // 0. 检验是否有值
            guard let anchor = anchor else { return }
            
            // 1. 在线人数
            var onlinStr : String = ""
            if anchor.online >= 10000 {
                onlinStr = "\(anchor.online/10000)万在线"
            }else{
                onlinStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlinStr, for: .normal)
            
            // 2. 昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3. 设置封面图片
            
        }
    }
}
