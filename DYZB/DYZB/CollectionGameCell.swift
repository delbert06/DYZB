//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 胡迪 on 2017/1/3.
//  Copyright © 2017年 D.Huhu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    // MARK: - 模型属性
    var baseGame : BaseModel?{
        didSet{
            titleLabel.text = baseGame?.tag_name
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImage.kf.setImage(with: iconURL)
            } else {
                iconImage.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
