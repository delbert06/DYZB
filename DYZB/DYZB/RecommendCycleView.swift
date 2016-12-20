//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/20.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

private let cycleViewCellID = "cycleViewCellID"

class RecommendCycleView: UIView {

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
//
    
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // colldectionView
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cycleViewCellID)
        print("wake")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        print("layout")
    }
}

extension RecommendCycleView {
    class func recommendCycleView() ->  RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleViewCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        
        return cell
    }
}