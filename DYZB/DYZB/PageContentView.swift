//
//  PageContentView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/24.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

protocol PageCollectViewDelegate : class {
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK: - 定义属性
    var chinldVCs:[UIViewController]
    weak var parentVC:UIViewController?
    var currentIndex : Int = 0
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelege : Bool = false
    weak var delegate : PageCollectViewDelegate?
    
    //MARK: - 懒加载属性
    lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //MARK: - 构造函数
    init(frame: CGRect,childVCs:[UIViewController],parentVC:UIViewController?) {
        self.chinldVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - 设置UI
extension PageContentView {
    func setupUI()  {
        for childVC in chinldVCs {
            parentVC?.addChildViewController(childVC)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chinldVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = chinldVCs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK: - 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currnetIndex: Int ){
        
        // 记录需要进制需要进行代理方法
        isForbidScrollDelege = true
        let offsetX = CGFloat(currnetIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offsetX, y : 0), animated: true)
    }
}

//MARK: - 遵守collectionViewDelegate
extension PageContentView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelege = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView:UIScrollView){
        
        // 0. 判断是否是点击事件
        if isForbidScrollDelege{return}
        // 1. 定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2. 判断向左或者向右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1. 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2. 计算sourceIndex 
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算targeIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= chinldVCs.count{
                targetIndex = chinldVCs.count - 1
            }
            // 4. 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            // 1. 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2. 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= chinldVCs.count {
                sourceIndex = chinldVCs.count - 1
            }
        }
        // 3. 把progress sourceIndex targerIndex 传递给titleView
//        print("progress:\(progress)","sourceIndex:\(sourceIndex)","targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



