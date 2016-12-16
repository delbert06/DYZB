//
//  PrettyCollectionViewCell.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/8.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class PrettyCollectionViewCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
        
        onlineBtn.layer.cornerRadius = 5
        onlineBtn.layer.masksToBounds = true
    }
    
    override var anchor : AnChorModel? {
        didSet{
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
