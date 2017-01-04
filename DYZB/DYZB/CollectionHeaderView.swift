//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/7.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup?{
        didSet{
            headerLabel.text = group?.tag_name
            headerImage.image = UIImage(named: group?.icon_name ?? "home_header_phone")
        }
    }
}
