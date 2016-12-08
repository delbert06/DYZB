//
//  NormalCollectionCell.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/7.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class NormalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImgView.layer.cornerRadius = 5
        ImgView.layer.masksToBounds = true
    }
}
