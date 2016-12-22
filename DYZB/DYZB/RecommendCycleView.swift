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
    
    // MARK: - 定义属性
    var cycleModels : [CycleModel]? = [CycleModel](){
        didSet{
            collectionView.reloadData()
            pageView.numberOfPages = cycleModels?.count ?? 0
        }
    }
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        
        
        // colldectionView
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleViewCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

// MARK: - 提供快速创建View的方法
extension RecommendCycleView {
    class func recommendCycleView() ->  RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: - 数据源方法
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleViewCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    }
}

// MARK : - 代理方法
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 获得滚动的偏移量
        // 加后边的scrollView.bounds.width * 0.5是为了拖动到一半就换页
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2. 计算pageControll的currentIndex
        pageView.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
