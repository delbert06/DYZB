//
//  PrettyCollectionViewCell.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/8.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class PrettyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var onLineLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        
        onLineLabel.layer.cornerRadius = 5
        onLineLabel.layer.masksToBounds = true
    }

}
