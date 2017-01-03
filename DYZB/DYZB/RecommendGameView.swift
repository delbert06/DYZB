//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/29.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

let gameCell = "kGameCellID"

class RecommendGameView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        autoresizingMask = UIViewAutoresizing()
//        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gameCell)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gameCell)
    }
//    
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : .blue
        
        return cell
    }
}
