//
//  NormalCollectionCell.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/7.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class NormalCollectionCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
    }
    
    override var anchor : AnChorModel? {
        didSet{
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
    }
}

