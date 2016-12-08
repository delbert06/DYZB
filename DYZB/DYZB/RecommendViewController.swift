//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/7.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

let kItemMargin :CGFloat = 10
let kItemW = (kScreenW - 3 * kItemMargin) / 2
let kItemH = kItemW * 3 / 4
let kNormalCellID = "kNormalCellID"
let kHeadView : CGFloat = 50
let kHeaderView = "kHeaderView"

class RecommendViewController: UIViewController {
    // MARK: - 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //为了防止超出屏幕范围(没有随着父控件缩小而缩小，Tabbar占据了一部分)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadView)
        // 边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]  // 排版自动布局
        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName:"NormalCollectionCell",bundle:nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"CollectionHeaderView",bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RecommendViewController{
    func setupUI(){
        view.addSubview(collectionView)
    }
}

extension RecommendViewController :UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 8}
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        return cell
    }
    
    // 头部view的实现
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderView, for: indexPath)
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
}
