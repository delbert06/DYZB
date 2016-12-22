//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/22.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let imgURL = URL(string:cycleModel?.pic_url ?? "")
            iconImage.kf.setImage(with: imgURL)
        }
    }

}
