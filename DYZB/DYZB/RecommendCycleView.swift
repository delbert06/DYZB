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
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? = [CycleModel](){
        didSet{
            // 1. 刷新collectionView数据
            collectionView.reloadData()
            // 2. 设置pageView的页数个数
            pageView.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        
        
        // 注册cell
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

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleViewCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 获得滚动的偏移量
        // 加后边的scrollView.bounds.width * 0.5是为了拖动到一半就换页
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2. 计算pageControll的currentIndex
        pageView.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        }
    
    // 防止拖拽的时候cell滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK:- 对定时器的操作方法
extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
