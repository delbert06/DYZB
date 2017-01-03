//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/29.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

let gameCell = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    // MARK: - 定义属性
    var groups : [AnchorGroup]?{
        didSet{
            groups?.removeFirst()
            groups?.removeFirst()
            let more = AnchorGroup()
            more.tag_name = "更多"
            groups?.append(more)
            collectionView.reloadData()
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册Cell
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCell)
        
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as!CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        return cell
    }
}
